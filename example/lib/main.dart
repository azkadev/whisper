import 'dart:io';
import 'dart:isolate';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whisper_dart/whisper_dart.dart';
import 'package:galaxeus_lib/galaxeus_lib.dart';
import "package:cool_alert/cool_alert.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Whisper Speech to Text'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  EventEmitter eventEmitter = EventEmitter();

  late String model = "";
  late String audio = "";
  late String result = "";
  late bool isProccess = false;

  @override
  void initState() {
    super.initState();

    task();
  }

  void task() async {
    ReceivePort receivePort = ReceivePort();

    ReceivePort secondReceivePort = ReceivePort();
    receivePort.listen((message) {
      if (message is WhisperResponse) {
        setState(() {
          result = message.toString();
        });
      }

      setState(() {
        isProccess = false;
      });
    });

    Isolate.spawn(
      (WhisperIsolateData whisperIsolateData) {
        Whisper whisper = Whisper();
        ReceivePort receivePort = ReceivePort();
        whisperIsolateData.secondSendPort.send(receivePort.sendPort);
        receivePort.listen((message) {
          if (message is WhisperData) {
            var res = whisper.request(
              request: WhisperRequest.fromWavFile(
                audio: File(message.audio),
                model: File(message.model),
              ),
            );
            whisperIsolateData.mainSendPort.send(res);
          } else {
            whisperIsolateData.mainSendPort.send("else");
          }
        });
      },
      WhisperIsolateData(
        mainSendPort: receivePort.sendPort,
        secondSendPort: secondReceivePort.sendPort,
      ),
    );

    final port = secondReceivePort.asBroadcastStream();
    final sendPort = await port.first;
    if (sendPort is SendPort) {
      eventEmitter.on("update", null, (ev, context) {
        if (ev.eventData is WhisperData) {
          sendPort.send((ev.eventData as WhisperData));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChooseWidget(
                isMain: !isProccess,
                mainWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? resul =
                              await FilePicker.platform.pickFiles();

                          if (resul != null) {
                            File file = File(resul.files.single.path!);
                            if (file.existsSync()) {
                              setState(() {
                                model = file.path;
                              });
                            }
                          }
                        },
                        child: const Text("set model"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? resul =
                              await FilePicker.platform.pickFiles();

                          if (resul != null) {
                            File file = File(resul.files.single.path!);
                            if (file.existsSync()) {
                              setState(() {
                                audio = file.path;
                              });
                            }
                          }
                        },
                        child: const Text("set audio"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (isProccess) {
                            return await CoolAlert.show(
                                context: context,
                                type: CoolAlertType.info,
                                text:
                                    "Tolong tunggu procces tadi sampai selesai ya");
                          }
                          if (audio.isEmpty) {
                            await CoolAlert.show(
                                context: context,
                                type: CoolAlertType.info,
                                text:
                                    "Maaf audio kosong tolong setting dahulu ya");
                            if (kDebugMode) {
                              print("audio is empty");
                            }
                            return;
                          }
                          if (model.isEmpty) {
                            await CoolAlert.show(
                                context: context,
                                type: CoolAlertType.info,
                                text:
                                    "Maaf model kosong tolong setting dahulu ya");
                            if (kDebugMode) {
                              print("model is empty");
                            }
                            return;
                          }
                          eventEmitter.emit(
                            "update",
                            null,
                            WhisperData(audio: audio, model: model),
                          );
                          setState(() {
                            isProccess = true;
                          });
                        },
                        child: const Text("Start"),
                      ),
                    ),
                  ],
                ),
                secondWidget: const CircularProgressIndicator(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("model: $model"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("audio: $audio"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Result: $result"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseWidget extends StatelessWidget {
  final bool isMain;
  final Widget mainWidget;
  final Widget secondWidget;
  const ChooseWidget({
    Key? key,
    this.isMain = true,
    required this.mainWidget,
    required this.secondWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMain) {
      return mainWidget;
    }
    return secondWidget;
  }
}

class WhisperData {
  late String audio;
  late String model;
  WhisperData({required this.audio, required this.model});
}

class WhisperIsolateData {
  final SendPort mainSendPort;
  final SendPort secondSendPort;
  WhisperIsolateData({
    required this.mainSendPort,
    required this.secondSendPort,
  });
}
