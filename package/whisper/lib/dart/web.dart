// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'package:general_lib/general_lib.dart';
import 'package:whisper/core/core.dart';

class Whisper extends WhisperBase {
  Whisper();

  static bool is_initialized = false;
  static String whisper_library_path = "";

  static bool get is_current_platform_supported {
    if (Dart.isWeb) {
      return false;
    }
    return Dart.isAndroid || Dart.isLinux;
  }

  static String defaultLibraryPath() {
    if (Dart.isWeb) {
      return "";
    }
    if (Dart.isAndroid || Dart.isLinux) {
      return "libwhisper.so";
    }
    return "";
  }

  static void initalized({
    String? libraryWhisperPath,
  }) {
    if (is_initialized) {
      return;
    }
    final String library_whisper_path = libraryWhisperPath ?? defaultLibraryPath();
    if (library_whisper_path.isNotEmpty) {
      whisper_library_path = library_whisper_path;
      is_initialized = true;
      return;
    }
    return;
  }
  
  @override
  String libraryPlatformName() {
    return "whisper_web";
  }
}
