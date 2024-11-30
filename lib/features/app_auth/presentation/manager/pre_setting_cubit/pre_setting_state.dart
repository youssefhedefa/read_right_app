enum PreSettingEnum{
  initial,
  loading,
  success,
  error,
}
enum AudioPreSettingEnum{
  initial,
  loading,
  success,
  error,
}
enum ImagePreSettingEnum{
  initial,
  loading,
  success,
  error,
}

class PreSettingState {
  final PreSettingEnum preSettingEnum;
  final AudioPreSettingEnum audioPreSettingEnum;
  final ImagePreSettingEnum imagePreSettingEnum;
  String? errorMessage;
  String? audioUrl;
  String? imageUrl;
  PreSettingState({
    required this.preSettingEnum,
    required this.audioPreSettingEnum,
    required this.imagePreSettingEnum,
    this.errorMessage,
    this.audioUrl,
    this.imageUrl,
  });

  PreSettingState copyWith({
    PreSettingEnum? preSettingEnum,
    AudioPreSettingEnum? audioPreSettingEnum,
    ImagePreSettingEnum? imagePreSettingEnum,
    String? message,
    String? audioUrl,
    String? imageUrl,
  }) {
    return PreSettingState(
      preSettingEnum: preSettingEnum ?? this.preSettingEnum,
      audioPreSettingEnum: audioPreSettingEnum ?? this.audioPreSettingEnum,
      imagePreSettingEnum: imagePreSettingEnum ?? this.imagePreSettingEnum,
      errorMessage: message,
      audioUrl: audioUrl,
      imageUrl: imageUrl,
    );
  }
}