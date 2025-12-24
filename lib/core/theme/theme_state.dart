import 'package:flutter/material.dart';

enum Gender { male, female }

extension GenderExtension on Gender {
  bool get isMale => this == Gender.male;
  bool get isFemale => this == Gender.female;
}

class ThemeState {
  final ThemeData themeData;
  final Gender gender;
  final Color primaryColor;
  final bool isLoading;

  ThemeState({
    required this.themeData,
    required this.gender,
    required this.primaryColor,
    this.isLoading = false,
  });

  factory ThemeState.initial() {
    return ThemeState(
      themeData: _getMaleTheme(),
      gender: Gender.male,
      primaryColor: const Color(0xFF2196F3),
      isLoading: false,
    );
  }

  ThemeState copyWith({
    ThemeData? themeData,
    Gender? gender,
    Color? primaryColor,
    bool? isLoading,
  }) {
    return ThemeState(
      themeData: themeData ?? this.themeData,
      gender: gender ?? this.gender,
      primaryColor: primaryColor ?? this.primaryColor,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool get isMale => gender == Gender.male;
  bool get isFemale => gender == Gender.female;

  String get genderString => gender == Gender.male ? 'male' : 'female';

  static ThemeData _getMaleTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2196F3)),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: const Color(0xFF2196F3),
    ).copyWith(
      textTheme: ThemeData().textTheme.apply(
            fontFamily: 'Rubik',
          ),
    );
  }

  static ThemeData _getFemaleTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE91E63)),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: const Color(0xFFE91E63),
    ).copyWith(
      textTheme: ThemeData().textTheme.apply(
            fontFamily: 'Rubik',
          ),
    );
  }

  static Gender genderFromString(String genderStr) {
    return genderStr.toLowerCase() == 'female' ? Gender.female : Gender.male;
  }

  static ThemeData getThemeForGender(Gender gender) {
    return gender == Gender.male ? _getMaleTheme() : _getFemaleTheme();
  }

  static Color getColorForGender(Gender gender) {
    return gender == Gender.male
        ? const Color(0xFF2196F3)
        : const Color(0xFFE91E63);
  }
}
