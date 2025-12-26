import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:read_right/generated/assets.dart';

class HomeLocalDataSource{
  Future<List<Map<String, dynamic>>> loadJsonFile({required Locale locale}) async {
    // Select the appropriate book file based on the current language
    final String booksJsonPath = locale.languageCode == 'ar'
        ? Assets.booksArBooks
        : Assets.booksEnBooks;

    final String response = await rootBundle.loadString(booksJsonPath);
    final List<Map<String, dynamic>> booksJson = json.decode(response).cast<Map<String, dynamic>>();
    return booksJson;
  }

}