import 'dart:io';

import "package:alfred/alfred.dart";
import 'package:whisper_dart/whisper_dart.dart';

void main(List<String> arguments) async {
  int port = int.parse(Platform.environment["PORT"] ?? "8080");
  String host = Platform.environment["HOST"] ?? "0.0.0.0";
  Whisper whisper = Whisper();
  Alfred app = Alfred(
    logLevel: LogType.error,
    onNotFound: (req, res) {
      return res.json({
        "@type": "error",
        "message": "path_not_found",
      });
    },
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

    if (method == "transcribeFromAudio") {
      
    }

    return {
      "@type": "ok",
    };
  });
  await app.listen(port, host);
}
