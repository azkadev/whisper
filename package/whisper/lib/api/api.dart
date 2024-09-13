// ignore_for_file: non_constant_identifier_names

import 'package:whisper/dart/dart.dart';
import 'package:whisper/scheme/api/api.dart';
import 'package:whisper/scheme/respond/respond.dart';

extension WhisperApiExtension on Whisper {
 

/// generate
  Future<Version> api_getVersion({
    required GetVersion getVersionParameters, 
  }) async { 
    return await invokeBuilder(
      parameters: getVersionParameters.toJson(), 
      onResult: (result) {
        return Version(result);
      },
    );
  }

/// generate
  Future<Ok> api_transcribeSync({
    required TranscribeSync transcribeSyncParameters, 
  }) async { 
    return await invokeBuilder(
      parameters: transcribeSyncParameters.toJson(), 
      onResult: (result) {
        return Ok(result);
      },
    );
  }

/// generate
  Future<Ok> api_transcribeRealtime({
    required TranscribeRealtime transcribeRealtimeParameters, 
  }) async { 
    return await invokeBuilder(
      parameters: transcribeRealtimeParameters.toJson(), 
      onResult: (result) {
        return Ok(result);
      },
    );
  }

}