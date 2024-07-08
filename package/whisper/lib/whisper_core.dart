// ignore_for_file: unnecessary_brace_in_string_interps

/* <!-- START LICENSE -->


Program Ini Di buat Oleh DEVELOPER Dari PERUSAHAAN GLOBAL CORPORATION 
Social Media: 

- Youtube: https://youtube.com/@Global_Corporation 
- Github: https://github.com/globalcorporation
- TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

Seluruh kode disini di buat 100% murni tanpa jiplak / mencuri kode lain jika ada akan ada link komment di baris code

Jika anda mau mengedit pastikan kredit ini tidak di hapus / di ganti!

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
// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'package:general_lib/general_lib.dart';
import 'package:whisper/scheme/api_scheme/get_text_from_wav_file.dart';
// import 'package:universal_io/io.dart';
import 'package:whisper/scheme/respond_scheme/respond_scheme.dart';

class Whisper {
  String whisper_lib = "libwhisper.${getFormatLibrary}";

  Whisper({
    String? whisperLib,
  }) {
    if (whisperLib != null) {
      whisper_lib = whisperLib;
    }
  }

  static String get getFormatLibrary {
    if (Dart.isAndroid || Dart.isLinux) {
      return "so";
    } else if (Dart.isIOS || Dart.isMacOS) {
      return "dylib";
    } else {
      return "dll";
    }
  }

  Future<JsonScheme> invokeRaw({
    required JsonScheme jsonScheme,
  }) async {
    return JsonScheme.create();
  }

  Future<JsonScheme> invoke({
    required JsonScheme jsonScheme,
  }) async {
    return await invokeRaw(jsonScheme: jsonScheme);
  }

  Future<JsonScheme> request({
    required JsonScheme jsonScheme,
    String? whisperLib,
  }) async {
    return await invoke(
      jsonScheme: jsonScheme,
    );
  }

  Future<Transcribe> getTextFromWavFile({
    required GetTextFromWavFile getTextFromWavFileParameter,
  }) async {
    return Transcribe.create();
  }

  Future<Version> getVersion() async {
    return Version.create();
  }
}
