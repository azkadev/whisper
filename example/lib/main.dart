import 'dart:io';
import 'dart:isolate';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:whisper_dart/whisper_dart.dart';
import 'package:galaxeus_lib/galaxeus_lib.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

  late String model = "/sdcard/models/ggml-model-whisper-small.bin";
  late String audio = "/sdcard/models/output_res.wav";
  late String result = "";
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
    });
    Isolate.spawn(
      (WhisperIsolateData whisperIsolateData) {
        Whisper whisper = Whisper(
          whisperLib: "galaxeus_ai.so",
        );
        ReceivePort receivePort = ReceivePort();
        whisperIsolateData.second_send_port.send(receivePort.sendPort);
        // var res = whisper.request(
        //   whisperRequest: WhisperRequest.fromWavFile(
        //     // audio: WhisperAudioconvert.convert(
        //     //   audioInput: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/audio.ogg"),
        //     //   audioOutput: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/output.wav"),
        //     // ),
        //     audio: File(whisperData.audio),
        //     model: File(whisperData.model),
        //   ),
        // );
        // print(res.toString());
        receivePort.listen((message) {
          if (message is WhisperData) {
            var res = whisper.request(
              whisperRequest: WhisperRequest.fromWavFile(
                // audio: WhisperAudioconvert.convert(
                //   audioInput: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/audio.ogg"),
                //   audioOutput: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/output.wav"),
                // ),
                audio: File(message.audio),
                model: File(message.model),
              ),
            );

            whisperIsolateData.main_send_port.send(res);
          } else {
            print(message);
          }
        });
      },
      WhisperIsolateData(
        main_send_port: receivePort.sendPort,
        second_send_port: secondReceivePort.sendPort,
      ),
    );

    final port = secondReceivePort.asBroadcastStream();
    final send_port = await port.first;
    if (send_port is SendPort) {
      eventEmitter.on("update", null, (ev, context) {
        if (ev.eventData is WhisperData) {
          send_port.send((ev.eventData as WhisperData));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? resul = await FilePicker.platform.pickFiles();

                        if (resul != null) {
                          File file = File(resul.files.single.path!);
                          if (file.existsSync()) {
                            setState(() {
                              model = file.path;
                            });
                          }
                        }
                      },
                      child: Text("set model"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? resul = await FilePicker.platform.pickFiles();

                        if (resul != null) {
                          File file = File(resul.files.single.path!);
                          if (file.existsSync()) {
                            setState(() {
                              audio = file.path;
                            });
                          }
                        }
                      },
                      child: Text("set audio"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (audio.isEmpty) {
                          print("audio is empty");
                          return;
                        }
                        if (model.isEmpty) {
                          print("model is empty");
                          return;
                        }
                        eventEmitter.emit(
                          "update",
                          null,
                          WhisperData(audio: audio, model: model),
                        );
                      },
                      child: Text("Start"),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("model: ${model}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("audio: ${audio}"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("Result: ${result}"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void transScribe({
    required String audio,
    required String model,
  }) {
    Isolate.spawn((WhisperData whisperData) {
      Whisper whisper = Whisper(
        whisperLib: "galaxeus_ai.so",
      );
      var res = whisper.request(
        whisperRequest: WhisperRequest.fromWavFile(
          // audio: WhisperAudioconvert.convert(
          //   audioInput: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/audio.ogg"),
          //   audioOutput: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/output.wav"),
          // ),
          audio: File(whisperData.audio),
          model: File(whisperData.model),
        ),
      );
      print(res.toString());
    }, WhisperData(audio: audio, model: model));
  }
}

class WhisperData {
  late String audio;
  late String model;
  WhisperData({required this.audio, required this.model});
}

class WhisperIsolateData {
  final SendPort main_send_port;
  final SendPort second_send_port;
  WhisperIsolateData({
    required this.main_send_port,
    required this.second_send_port,
  });
}
