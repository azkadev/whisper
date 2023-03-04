// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:io';

import "package:alfred/alfred.dart";
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:isar/isar.dart';
import 'package:whisper_dart/whisper_dart.dart';
import 'package:whisper_server/scheme/scheme.dart' as whisper_scheme;
import 'package:whisper_server/isar_scheme/isar_scheme.dart' as isar_scheme;
import 'package:path/path.dart' as path;

void main(List<String> arguments) async {
  Directory directory_db = Directory(path.join(Directory.current.path, "db"));
  Directory directory_temp = Directory(path.join(Directory.current.path, "temp"));

  if (!directory_db.existsSync()) {
    await directory_db.create(recursive: true);
  }
  if (!directory_temp.existsSync()) {
    await directory_temp.create(recursive: true);
  }

  int port = int.parse(Platform.environment["PORT"] ?? "8080");
  String host = Platform.environment["HOST"] ?? "0.0.0.0";
  Whisper whisper = Whisper();
  int count_task = 0;
  int max_task = 1;

  Alfred app = Alfred(
    logLevel: LogType.error,
    onNotFound: (req, res) {
      return res.json({
        "@type": "error",
        "message": "path_not_found",
      });
    },
  );

  Isar db = await Isar.open(
    [
      isar_scheme.TranscribeSchema,
    ],
    name: "db",
    maxSizeMiB: Isar.defaultMaxSizeMiB * 10,
    directory: directory_db.path,
    inspector: false,
  );
  app.all('*', (req, res) {});
  app.all("/", (HttpRequest req, HttpResponse res) async {
    return {
      "@type": "ok",
    };
  });

  app.all("/api", (req, res) async {
    if (req.method.toLowerCase() != "post") {
      return {
        "@type": "error",
      };
    }
    Map body = await req.bodyAsJsonMap;
    String method = "";

    if (body["@type"] is String) {
      method = body["@type"];
    }

    if (method.isEmpty) {
      return {
        "@type": "error",
        "message": "method_must_be_not_empty",
      };
    }

    if (method == "getTextFromAudio") {
      whisper_scheme.GetTextFromAudio getTextFromAudio = whisper_scheme.GetTextFromAudio(body);
      String? name_audio = getTextFromAudio.name;
      name_audio ??= "";
      List<int> data_audio = getTextFromAudio.data;

      if (data_audio.isEmpty) {
        return whisper_scheme.Error.create(special_type: "error", message: "data_audio_must_be_not_empty", description: "Data Audio Harus ada").toJson();
      }

      if (name_audio.isEmpty) {
        return whisper_scheme.Error.create(special_type: "error", message: "name_audio_must_be_not_empty", description: "Name Audio Harus ada").toJson();
      }
      String key = "";
      String password = "";
      DateTime expire_date = DateTime.now().add(Duration(minutes: 5));
      DateTime time_out = DateTime.now().add(Duration(seconds: 10));
      bool res = await db.writeTxn<bool>(
        () async {
          isar_scheme.Transcribe transcribe_new_data = isar_scheme.Transcribe();
          while (true) {
            if (time_out.isExpired()) {
              return false;
            }
            try {
              isar_scheme.Transcribe? transcribe_data = await db.transcribes.filter().keyEqualTo(key).passwordEqualTo(password).findFirst();
              if (transcribe_data == null) {
                transcribe_new_data.key = key;
                transcribe_new_data.password = password;
                await db.transcribes.put(transcribe_new_data);
                return true;
              }
              key = generateUuid(10);
              password = generateUuid(10);
            } catch (e) {
              return false;
            }
          }
        },
        silent: true,
      );

      if (!res) {
        return whisper_scheme.Error.create(
          special_type: "error",
          message: "data_audio_must_be_not_empty",
          description: "Data Audio Harus ada",
        ).toJson();
      }

      return whisper_scheme.Task.create(
        special_type: "task",
        key: key,
        password: password,
        expire_date: expire_date.millisecondsSinceEpoch,
      ).toJson();
    }

    return {
      "@type": "ok",
    };
  });

  await app.listen(
    port,
    host,
  );
  print("server run");
  Timer.periodic(Duration(milliseconds: 500), (Timer timer) async {
    if (count_task >= max_task) {
      return;
    }
    count_task++;
    try {
      await whisper.transcribe(
        audio: "audio",
        model: "audio",
      );
    } catch (e) {}
    count_task--;
  });
}
