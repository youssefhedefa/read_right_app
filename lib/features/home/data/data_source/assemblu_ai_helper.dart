import 'dart:ui';

import 'package:assemblyai_flutter_sdk/assemblyai_flutter_sdk.dart';

class AssemblyAiHelper {
  final assApi = AssemblyAI('3f2af4a5c112490796e4f5d8583ce896');

  Future<String> makeRequest(
      {required String audioUrl, required Locale locale}) async {
    if (locale.languageCode == 'ar') {
      return arabicTranscription(audioUrl: audioUrl);
    }
    return englishTranscription(audioUrl: audioUrl);
  }

  Future<String> englishTranscription({required String audioUrl}) async {
    // final transcription = await assApi.submitTranscription({
    //   'audio_url': audioUrl,
    //   'language_code': locale,
    //   'punctuate': true,
    // });
    // print(transcription.id);
    // return transcription.id;
    final transcription = await assApi.submitTranscription({
      'audio_url': audioUrl,
      'language_code': 'en',
      'punctuate': true,
    });
    return transcription.id;
  }

  Future<String> arabicTranscription({required String audioUrl}) async {
    final transcription = await assApi.submitTranscription({
      'audio_url': audioUrl,
      'language_code': 'ar',
      'speech_model': 'nano',
      'punctuate': true,
    });
    return transcription.id;
  }

  Future<dynamic> checkTranscription(String id) async {
    final transcription = await assApi.getTranscription(id);
    print(transcription.status);
    if (transcription.status == 'processing' ||
        transcription.status == 'queued') {
      Future.delayed(
        const Duration(seconds: 2),
      );
      return checkTranscription(id);
    } else if (transcription.status == 'error') {
      print(transcription.error);
      return null;
    } else if (transcription.status == 'completed') {
      return transcription.text;
    }
    return null;
  }
}
