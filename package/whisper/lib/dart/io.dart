// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:general_lib/general_lib.dart';
import 'package:whisper/core/core.dart';

typedef WhisperStringNative = Pointer<Utf8>;
typedef WhisperCharNative = Pointer<Char>;

typedef WhisperPrintNative = Void Function(WhisperCharNative data);
typedef WhisperPrintDart = void Function(WhisperCharNative data);

typedef WhisperRequestNative = WhisperCharNative Function(WhisperCharNative data);

class Whisper extends WhisperBase {
  Whisper();

  static bool is_initialized = false;
  static late final DynamicLibrary whisper_library;
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

  static late final WhisperRequestNative whisper_request_function;
  static late final WhisperPrintDart whisper_print_function;

  static void initalized({
    String? libraryWhisperPath,
  }) {
    if (is_initialized) {
      return;
    }
    final String library_whisper_path = libraryWhisperPath ?? defaultLibraryPath();
    if (library_whisper_path.isNotEmpty) {
      whisper_library_path = library_whisper_path;
      whisper_library = DynamicLibrary.open(library_whisper_path);
      whisper_request_function = whisper_library.lookupFunction<WhisperRequestNative, WhisperRequestNative>("request");
      whisper_print_function = whisper_library.lookupFunction<WhisperPrintNative, WhisperPrintDart>("print");
      is_initialized = true;
      return;
    }
    return;
  }

  static Map whisper_invoke({
    required Map parameters,
  }) {
    final WhisperCharNative data_native = json.encode(parameters).toNativeUtf8().cast<Char>();
    final WhisperCharNative request_result_char = whisper_request_function(data_native);
    malloc.free(data_native);
    final Map result = json.decode(request_result_char.cast<Utf8>().toDartString());
    malloc.free(request_result_char);
    return result;
  }

  @override
  Map invokeSync({
    required Map parameters,
  }) {
    return whisper_invoke(parameters: parameters);
  }

  @override
  Future<Map> invoke({
    required Map parameters,
  }) async {
    final String whisper_library_path = Whisper.whisper_library_path;
    return await Isolate.run<Map>(() {
      Whisper.initalized(
        libraryWhisperPath: whisper_library_path,
      );
      return Whisper.whisper_invoke(parameters: parameters);
    });
  }

  @override
  String libraryPlatformName() {
    return "whisper_io";
  }
}
