// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:general_lib/general_lib.dart';
import 'package:whisper/core/core.dart';

typedef WhisperPrintNative = Void Function(Pointer<Utf8> data);
typedef WhisperPrintDart = void Function(Pointer<Utf8> data);
typedef WhisperRequestNative = Pointer<Utf8> Function(Pointer<Utf8> data);
typedef WhisperRequestDart = Pointer<Utf8> Function(Pointer<Utf8> data);

class WhisperDart implements Whisper {
  static bool is_initialized = false;
  static late final DynamicLibrary whisper_library;
  static String whisper_library_path = "";

  static bool get is_current_platform_supported {
    if (Dart.isWeb) {
      return false;
    }
    return Dart.isAndroid || Dart.isLinux;
  }

  WhisperDart();

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
      whisper_library = DynamicLibrary.open(library_whisper_path);
      is_initialized = true;
      return;
    }
    return;
  }

  @override
  void print(dynamic value) {
    final Pointer<Utf8> data_native = "${value.toString()}".toNativeUtf8();
    whisper_library.lookupFunction<WhisperPrintNative, WhisperPrintDart>("print").call(data_native);
    malloc.free(data_native);
  }

  @override
  Map invoke({
    required Map parameters,
  }) {
    final Pointer<Utf8> data_native = json.encode(parameters).toNativeUtf8();
    final Pointer<Utf8> request_result = whisper_library.lookupFunction<WhisperRequestNative, WhisperRequestDart>("request").call(data_native);
    malloc.free(data_native);
    final Map result = json.decode(request_result.toDartString());
    malloc.free(request_result);
    return result;
  }

  @override
  JsonScheme requst({
    required JsonScheme parameters,
  }) {
    return JsonScheme(invoke(parameters: parameters.toJson()));
  }
}
