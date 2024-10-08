// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:async';

import 'package:general_lib/general_lib.dart';

abstract class WhisperBaseCore {
  String libraryPlatformName() {
    return "whisper_base_core";
  }
}

abstract class WhisperBase implements WhisperBaseCore {
  static bool is_initialized = false;
  static late final dynamic whisper_library;
  static String whisper_library_path = "";

  static bool get is_current_platform_supported {
    if (Dart.isWeb) {
      return false;
    }
    return Dart.isAndroid || Dart.isLinux;
  }

  WhisperBase();

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
      whisper_library = "";
      is_initialized = true;
      return;
    }
    return;
  }

  Map invokeSync({
    required Map parameters
  }) {
    return {};
  }


  T invokeSyncBuilder<T>({
    required Map parameters,
    required T Function(Map result) onResult,
  }){
    return onResult(invokeSync(parameters: parameters));
  }

  Future<Map> invoke({
    required Map parameters
  }) async{
    return {};
  }

  Future<T> invokeBuilder<T>({
    required Map parameters,
    required FutureOr<T> Function(Map result) onResult,
  }) async{
    return await onResult(await invoke(parameters: parameters));
  }
}
