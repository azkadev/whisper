// ignore_for_file: always_specify_types
// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef whisper_request_native = Pointer<Utf8> Function(Pointer<Utf8> body);
typedef _wrappedPrint_C = Void Function(Pointer<Utf8> a);

class WhisperDartBindings {
  final Pointer<T> Function<T extends NativeType>(String symbolName) _lookup;

  WhisperDartBindings(DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup {
    initPrintWrapperCallback();
  }

  WhisperDartBindings.fromLookup(
    Pointer<T> Function<T extends NativeType>(String symbolName) lookup,
  ) : _lookup = lookup;

  static void _wrappedPrint(Pointer<Utf8> arg) {
    log(arg.toDartString(), name: 'ffi:whisper_dart', level: 800);
  }

  void initPrintWrapperCallback() {
    _whisper_initialize(wrappedPrintPointer);
  }

  final wrappedPrintPointer =
      Pointer.fromFunction<_wrappedPrint_C>(_wrappedPrint);

  late final _whisper_initializePtr =
      _lookup<NativeFunction<Void Function(Pointer)>>("initialize");

  late final _whisper_initialize =
      _whisper_initializePtr.asFunction<void Function(Pointer)>();

  String request({required String whisperRequest}) {
    var res = _whisper_request(whisperRequest.toNativeUtf8());
    return res.toDartString();
  }

  late final _whisper_requestPtr =
      _lookup<NativeFunction<whisper_request_native>>('request');

  late final _whisper_request =
      _whisper_requestPtr.asFunction<whisper_request_native>();
}
