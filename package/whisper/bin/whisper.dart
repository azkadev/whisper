import 'package:general_lib/general_lib.dart';
import 'package:whisper/scheme/api/api.dart';
import 'package:whisper/whisper.dart';

void main(List<String> arguments) async {
  print("Hello Start");

  Whisper.initalized(
    libraryWhisperPath: "/home/galaxeus/Documents/librarys/whisper/native/build/lib/libwhisper.so",
  );
  final Whisper whisper = Whisper();
  final result = await whisper.api_getVersion(getVersionParameters: GetVersion.create());
  result.rawData.printPretty();
  // print(whisper.libraryPlatformName());
  // final result = await whisper.invokeBuilder(
  //   parameters: {
  //     "@type": "getVersion",
  //   },
  //   onResult: (result) {
  //     return result;
  //   },
  // );
  // result.printPretty();
}
