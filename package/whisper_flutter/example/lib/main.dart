// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, depend_on_referenced_packages

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whisper_flutter/whisper_flutter.dart';
import "package:cool_alert/cool_alert.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Whisper Speech to Text'),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String model = "";
  String audio = "";
  String result = "";
  bool is_procces = false;

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
              Visibility(
                visible: !is_procces,
                child: Row(
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
                          if (is_procces) {
                            return await CoolAlert.show(
                              context: context,
                              type: CoolAlertType.info,
                              text:
                                  "Tolong tunggu procces tadi sampai selesai ya",
                            );
                          }
                          if (audio.isEmpty) {
                            await CoolAlert.show(
                              context: context,
                              type: CoolAlertType.info,
                              text:
                                  "Maaf audio kosong tolong setting dahulu ya",
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
                                text:
                                    "Maaf model kosong tolong setting dahulu ya");
                            if (kDebugMode) {
                              print("model is empty");
                            }
                            return;
                          }

                          Future(() async {
                            print("Started transcribe");

                            Whisper whisper = Whisper(
                              whisperLib: "libwhisper.so",
                            );
                            var res = await whisper.request(
                              whisperLib: "libwhisper.so",
                              whisperRequest: WhisperRequest.fromWavFile(
                                audio: File(audio),
                                model: File(model),
                              ),
                            );
                            setState(() {
                              result = res.toString();
                              is_procces = false;
                            });
                          });
                          setState(() {
                            is_procces = true;
                          });
                        },
                        child: const Text("Start"),
                      ),
                    ),
                  ],
                ),
                replacement: const CircularProgressIndicator(),
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
