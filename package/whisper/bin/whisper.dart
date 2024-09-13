import 'package:general_lib/general_lib.dart';
import 'package:whisper/whisper.dart';

void main(List<String> arguments) async {
  print("Hello Start");

  Whisper.initalized(
    libraryWhisperPath: "/home/galaxeus/Documents/librarys/whisper/native/build/lib/libwhisper.so",
  );
  final Whisper whisper = Whisper();
  // print(whisper.libraryPlatformName());
  final result = await whisper.invokeBuilder(
    parameters: {
      "@type": "getVersion",
    },
    onResult: (result) {
      return result;
    },
  );
  result.printPretty();  
}
