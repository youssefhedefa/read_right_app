import 'dart:ui';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextHelper {
  stt.SpeechToText? _speech;
  String _lastRecognizedText = '';
  bool _isInitialized = false;

  Future<bool> initialize() async {
    if (_isInitialized) return true;

    _speech = stt.SpeechToText();
    _isInitialized = await _speech!.initialize(
      onStatus: (status) {
        print('Speech status: $status');
        if (status == 'done' || status == 'notListening') {
          print('Final recognized text: $_lastRecognizedText');
        }
      },
      onError: (error) {
        print('Speech error: ${error.errorMsg}');
      },
    );

    return _isInitialized;
  }

  Future<String> startListening({required Locale locale}) async {
    if (_speech == null || !_isInitialized) {
      await initialize();
    }

    if (_speech == null || !_isInitialized) {
      throw Exception('Speech recognition not available');
    }

    // Reset the recognized text at the start
    _lastRecognizedText = '';

    await _speech!.listen(
      onResult: (result) {
        // Update the last recognized text with the latest result
        _lastRecognizedText = result.recognizedWords;
        print('Current recognized: $_lastRecognizedText (final: ${result.finalResult})');
      },
      localeId: _getLocaleId(locale),
      listenOptions: stt.SpeechListenOptions(
        listenMode: stt.ListenMode.confirmation,
        cancelOnError: false,
        partialResults: true,
        autoPunctuation: true,
        enableHapticFeedback: true,
      ),
      listenFor: const Duration(seconds: 30), // Maximum listening time
      pauseFor: const Duration(seconds: 3), // Pause detection
    );

    return _lastRecognizedText;
  }

  Future<String> stopListening() async {
    if (_speech != null && _speech!.isListening) {
      await _speech!.stop();
    }

    // Wait a bit for final results to come through
    await Future.delayed(const Duration(milliseconds: 500));

    print('Stopped listening. Final text: $_lastRecognizedText');
    return _lastRecognizedText;
  }

  Future<String> transcribeAudio({
    required String audioPath,
    required Locale locale,
  }) async {
    // For recorded audio, we return the last recognized text
    // In real-world scenario, you might want to use a different library
    // that supports file transcription (like google_speech or cloud services)

    // Since speech_to_text doesn't support file transcription,
    // we'll return the last recognized text from the live recording
    return _lastRecognizedText;
  }

  String _getLocaleId(Locale locale) {
    if (locale.languageCode == 'ar') {
      return 'ar_SA'; // Arabic (Saudi Arabia)
    } else if (locale.languageCode == 'en') {
      return 'en_US'; // English (US)
    } else {
      return 'en_US'; // Default to English
    }
  }

  bool get isListening => _speech?.isListening ?? false;

  String get lastRecognizedText => _lastRecognizedText;

  Future<List<stt.LocaleName>> getAvailableLocales() async {
    if (_speech == null || !_isInitialized) {
      await initialize();
    }
    return _speech?.locales() ?? [];
  }

  Future<void> dispose() async {
    if (_speech != null) {
      await _speech!.stop();
      _speech = null;
      _isInitialized = false;
    }
  }
}

