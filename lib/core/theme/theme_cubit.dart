import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/theme/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  static const String _genderKey = 'user_gender';

  /// Load saved theme from SharedPreferences on app start
  Future<void> loadTheme() async {
    emit(state.copyWith(isLoading: true));

    try {
      final prefs = await SharedPreferences.getInstance();
      final genderString = prefs.getString(_genderKey) ?? 'male';
      final gender = ThemeState.genderFromString(genderString);

      emit(state.copyWith(
        gender: gender,
        themeData: ThemeState.getThemeForGender(gender),
        primaryColor: ThemeState.getColorForGender(gender),
        isLoading: false,
      ));
    } catch (e) {
      // If there's an error, fallback to default (male) theme
      emit(ThemeState.initial());
    }
  }

  /// Update theme based on gender selection
  Future<void> updateTheme(String genderString) async {
    emit(state.copyWith(isLoading: true));

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_genderKey, genderString);

      final gender = ThemeState.genderFromString(genderString);

      emit(state.copyWith(
        gender: gender,
        themeData: ThemeState.getThemeForGender(gender),
        primaryColor: ThemeState.getColorForGender(gender),
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Update theme using Gender enum directly
  Future<void> updateThemeByGender(Gender gender) async {
    await updateTheme(gender == Gender.male ? 'male' : 'female');
  }

  /// Check if current theme is male
  bool get isMaleTheme => state.isMale;

  /// Check if current theme is female
  bool get isFemaleTheme => state.isFemale;

  /// Get current gender as string
  String get currentGender => state.genderString;

  /// Get current primary color
  Color get primaryColor => state.primaryColor;
}
