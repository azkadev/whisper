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
// ignore_for_file: non_constant_identifier_names, public_member_api_docs

library;

import 'dart:convert';
import 'dart:io';
 

class FFmpeg {
  late String path_ffmpeg = "ffmpeg";
  FFmpeg({String? pathFFmpeg}) {
    pathFFmpeg ??= path_ffmpeg;
  }

  Future<FFmpegRawResponse> invoke({
    String? pathFFmpeg,
    FFmpegArgs? fFmpegArgs,
    String? workingDirectory,
    Map<String, String>? environment,
    bool includeParentEnvironment = true,
    bool runInShell = false,
  }) async {
    fFmpegArgs ??= FFmpegArgs([]);
    pathFFmpeg ??= path_ffmpeg;
    ProcessResult res = await Process.run(
      pathFFmpeg,
      fFmpegArgs.toList(),
      workingDirectory: workingDirectory,
      environment: environment,
      includeParentEnvironment: includeParentEnvironment,
      runInShell: runInShell,
    );
    if (res.exitCode == 0) {
      return FFmpegRawResponse(
        rawData: {"@type": "ok", "message": res.stdout},
        processResult: res,
      );
    } else {
      return FFmpegRawResponse(
        rawData: {"@type": "error", "message": res.stderr},
        processResult: res,
      );
    }
  }

  FFmpegRawResponse invokeSync({
    String? pathFFmpeg,
    FFmpegArgs? fFmpegArgs,
    String? workingDirectory,
    Map<String, String>? environment,
    bool includeParentEnvironment = true,
    bool runInShell = false,
  }) {
    fFmpegArgs ??= FFmpegArgs([]);
    pathFFmpeg ??= path_ffmpeg;
    ProcessResult res = Process.runSync(
      pathFFmpeg,
      fFmpegArgs.toList(),
      workingDirectory: workingDirectory,
      environment: environment,
      includeParentEnvironment: includeParentEnvironment,
      runInShell: runInShell,
    );
    if (res.exitCode == 0) {
      return FFmpegRawResponse(
        rawData: {"@type": "ok", "message": res.stdout},
        processResult: res,
      );
    } else {
      return FFmpegRawResponse(
        rawData: {"@type": "error", "message": res.stderr},
        processResult: res,
      );
    }
  }
}

class FFmpegArgs {
  late List<String> rawData;
  late ProcessResult processResult;
  FFmpegArgs(this.rawData);

  List<String> toList() {
    return rawData;
  }
}

class FFmpegRawResponse {
  late Map rawData;
  late ProcessResult processResult;
  FFmpegRawResponse({
    required this.rawData,
    required this.processResult,
  });

  String? get special_type {
    try {
      return rawData["@type"] as String;
    } catch (e) {
      return null;
    }
  }

  Map toJson() {
    return rawData;
  }

  Map toMap() {
    return rawData;
  }

  @override
  String toString() {
    return json.encode(rawData);
  }
}

class FFmpegResponse {
  FFmpegResponse();
}
