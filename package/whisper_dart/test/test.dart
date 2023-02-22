// import 'package:universal_io/io.dart';
// import 'package:galaxeus_lib/json_to_script_dart/json_to_script.dart';
// // import 'package:path/path.dart' as p;

// void main() async {
//   await jsonToScripts(
//     [
//       {
//         "@type": "getTextFromWavFile",
//         "is_translate": false,
//         "threads": 12,
//         "is_verbose": false,
//         "language": "id",
//         "is_special_tokens": false,
//         "is_no_timestamps": false,
//         "audio": "./audio.wav",
//         "model": "./model.bin",
//       },
//       {
//         "@type": "getVersion",
//       }
//     ],
//     directory: Directory(
//       p.join(Directory.current.path, "lib", "api"),
//     ),
//   );
//   await jsonToScripts(
//     [
//       {
//         "@type": "Transcribe",
//         "text": "",
//       },
//       {
//         "@type": "Version",
//         "message": "",
//       },
//       {
//         "@type": "Error",
//         "message": "",
//       },
//       {"@type": "WhisperResponse", "text": "", "message": ""},
//     ],
//     directory: Directory(
//       p.join(Directory.current.path, "lib", "scheme"),
//     ),
//   );
// }
