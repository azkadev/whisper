/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, depend_on_referenced_packages

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
  late bool is_procces = false;
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
        is_procces = false;
      });
    });
    Isolate.spawn(
      (WhisperIsolateData whisperIsolateData) {
        Whisper whisper = Whisper(
          whisperLib: "whisper_dart.so",
        );
        ReceivePort receivePort = ReceivePort();
        whisperIsolateData.second_send_port.send(receivePort.sendPort);
        receivePort.listen((message) {
          if (message is WhisperData) {
            var res = whisper.request(
              whisperLib: "whisper_dart.so",
              whisperRequest: WhisperRequest.fromWavFile(
                audio: File(message.audio),
                model: File(message.model),
              ),
            );
            whisperIsolateData.main_send_port.send(res);
          } else {
            whisperIsolateData.main_send_port.send("else");
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
              ChooseWidget(
                is_main: !is_procces,
                main_widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
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
                        child: const Text("set model"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
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
                        child: const Text("set audio"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (is_procces) {

                            return await CoolAlert.show(
                              context: context,
                              type: CoolAlertType.info,
                              text: "Tolong tunggu procces tadi sampai selesai ya"
                            );
                          }
                          if (audio.isEmpty) {
                            await CoolAlert.show(
                              context: context,
                              type: CoolAlertType.info,
                              text: "Maaf audio kosong tolong setting dahulu ya"
                            );
                            if (kDebugMode) {
                              print("audio is empty");
                            }
                            return;
                          }
                          if (model.isEmpty) {
                            await CoolAlert.show(
                              context: context,
                              type: CoolAlertType.info,
                              text: "Maaf model kosong tolong setting dahulu ya"
                            );
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
                            is_procces = true;
                          });
                        },
                        child: const Text("Start"),
                      ),
                    ),
                  ],
                ),
                second_widget: const CircularProgressIndicator(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("model: ${model}"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("audio: ${audio}"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Result: ${result}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseWidget extends StatelessWidget {
  final bool is_main;
  final Widget main_widget;
  final Widget second_widget;
  const ChooseWidget({
    Key? key,
    this.is_main = true,
    required this.main_widget,
    required this.second_widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (is_main) {
      return main_widget;
    }
    return second_widget;
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
