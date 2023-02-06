import 'dart:ffi';

import 'package:ffi/ffi.dart';

/// Don't forget to run malloc.free with result!
Pointer<Pointer<Utf8>> strListToPointer(List<String> strings) {
  List<Pointer<Utf8>> utf8PointerList =
      strings.map((str) => str.toNativeUtf8()).toList();

  final Pointer<Pointer<Utf8>> pointerPointer =
      malloc.allocate(utf8PointerList.length);

  strings.asMap().forEach((index, utf) {
    pointerPointer[index] = utf8PointerList[index];
  });

  return pointerPointer;
}
