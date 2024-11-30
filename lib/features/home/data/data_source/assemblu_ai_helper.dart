import 'package:assemblyai_flutter_sdk/assemblyai_flutter_sdk.dart';

class AssemblyAiHelper {
  final assApi = AssemblyAI('68021e31c46b437f8c43c9af005f424e');

  Future<String> makeRequest({required String audioUrl , required String locale}) async {
    final transcription = await assApi.submitTranscription({
      'audio_url': audioUrl,
      'language_code': locale,
      // 'language_code': 'ar_SA',
      'punctuate': true,
    });
    print(transcription.id);
    return transcription.id;
  }

  Future<dynamic> checkTranscription(String id) async {
    final transcription = await assApi.getTranscription(id);
    print(transcription.status);
    if(transcription.status == 'processing'){
      Future.delayed(
          const Duration(seconds: 2),
      );
      return checkTranscription(id);
    }
    else if(transcription.status == 'error'){
      print(transcription.error);
      return null;
    }
    else if(transcription.status == 'completed'){
      return transcription.text;
    }
    return null;
  }

}