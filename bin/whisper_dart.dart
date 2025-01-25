/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
// ignore_for_file: non_constant_identifier_names

import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:universal_io/io.dart';
import 'package:whisper_dart/whisper_dart.dart';
import 'package:ffmpeg_dart/ffmpeg_dart.dart';

void main(List<String> arguments) {
  DateTime time = DateTime.now();
  // print(res);
  Whisper whisper = Whisper(
    whisperLib: "native_lib/whisper_dart.so",
  );
  try {
    var res = whisper.request(
      whisperRequest: WhisperRequest.fromWavFile(
        // audio: WhisperAudioconvert.convert(
        //   audioInput: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/audio.ogg"),
        //   audioOutput: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/output.wav"),
        // ),
        audio: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/samples/output.wav"),
        model: File("/home/hexaminate/Documents/HEXAMINATE/app/ai/whisper_dart/models/ggml-model-whisper-small.bin"),
      ),
    );
    print(res.toString());
    print(convertToAgo(time.millisecondsSinceEpoch));
  } catch (e) {
    print(e);
  }
}
