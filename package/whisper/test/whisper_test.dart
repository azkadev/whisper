import 'dart:ffi';

import 'package:ffi/ffi.dart';

typedef PrintNative = Void Function(Pointer<Utf8> data);
typedef PrintDart = void Function(Pointer<Utf8> data);

void main() async {
  print("start");
  final DynamicLibrary dynamicLibrary = DynamicLibrary.open("/home/galaxeus/Documents/librarys/whisper/native/build/lib/libwhisper.so");
  print("open library");

  // dynamicLibrary;
  Pointer<Utf8> data_native = "Hello".toNativeUtf8();
  dynamicLibrary.lookupFunction<PrintNative, PrintDart>("print").call(data_native);
  malloc.free(data_native);
  print("done");
}
