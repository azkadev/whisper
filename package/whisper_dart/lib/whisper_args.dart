import 'dart:ffi';

import 'package:ffi/ffi.dart';

class WhisperArgs {
  List<String> args;
  WhisperArgs(this.args);
  Pointer<Pointer<Utf8>> toNativeList() {
    List<Pointer<Utf8>> utf8PointerList =
        args.map((str) => str.toNativeUtf8()).toList();
    final Pointer<Pointer<Utf8>> pointerPointer =
        malloc.allocate(utf8PointerList.length);
    args.asMap().forEach((index, utf) {
      pointerPointer[index] = utf8PointerList[index];
    });
    return pointerPointer;
  }
}
