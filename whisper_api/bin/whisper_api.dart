import 'dart:io';
import 'dart:isolate';

import 'package:alfred/alfred.dart';
import 'package:whisper_dart/whisper_dart.dart';
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:path/path.dart' as p;

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

void main(List<String> arguments) async {
  Alfred app = Alfred();
  String host = Platform.environment["HOST"] ?? "0.0.0.0";
  int port = int.parse(Platform.environment["PORT"] ?? "8080");

  EventEmitter eventEmitter = EventEmitter();

  ReceivePort receivePort = ReceivePort();

  ReceivePort secondReceivePort = ReceivePort();

  List<Map> datas = [];
  receivePort.listen((message) {
    if (message is WhisperResponse) {
      datas.add(message.toJson());
    }

    // setState(() {
    //   is_procces = false;
    // });
  });

  await Isolate.spawn(
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

  final port_data = secondReceivePort.asBroadcastStream();
  final send_port = await port_data.first;
  if (send_port is SendPort) {
    eventEmitter.on("update", null, (ev, context) {
      if (ev.eventData is WhisperData) {
        send_port.send((ev.eventData as WhisperData));
      }
    });
  }

  app.all("/", (req, res) async {
    return res.json({
      "@type": "data",
    });
  });
  app.all("/last", (req, res) async { 
    return res.json({
      "@type": "datas",
      "datas": datas.last,
    });
  });
  app.all("/data", (req, res) async { 
    return res.json({
      "@type": "datas",
      "datas": datas,
    });
  });
  app.all("/test", (req, res) async {
    eventEmitter.emit(
      "update",
      null,
      WhisperData(
        audio: Directory(p.join(Directory.current.path, "data", "audio.wav")).path,
        model: Directory(p.join(Directory.current.path, "data", "ggml-model-whisper-base.bin")).path,
      ),
    );
    return res.json({
      "@type": "procces",
    });
  });

  await app.listen(port, host);
}
