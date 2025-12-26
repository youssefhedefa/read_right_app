import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:read_right/generated/assets.dart';

class HomeLocalDataSource {
  Future<List<Map<String, dynamic>>> loadJsonFile(
      {required Locale locale}) async {
    // Select the appropriate book file based on the current language
    final String booksJsonPath =
        locale.languageCode == 'ar' ? Assets.booksArBooks : Assets.booksEnBooks;

    final String response = await rootBundle.loadString(booksJsonPath);
    final List<Map<String, dynamic>> booksJson =
        json.decode(response).cast<Map<String, dynamic>>();
    return booksJson;
  }

  Future<List<Map<String, dynamic>>> loadAllJsonFile(
      {required Locale locale}) async {
    // combine both language files
    const String booksJsonPathAr = Assets.booksArBooks;
    const String booksJsonPathEn = Assets.booksEnBooks;
    final String responseAr = await rootBundle.loadString(booksJsonPathAr);
    final String responseEn = await rootBundle.loadString(booksJsonPathEn);
    final List<Map<String, dynamic>> booksJsonAr =
        json.decode(responseAr).cast<Map<String, dynamic>>();
    final List<Map<String, dynamic>> booksJsonEn =
        json.decode(responseEn).cast<Map<String, dynamic>>();
    final List<Map<String, dynamic>> combinedBooksJson = [];
    combinedBooksJson.addAll(booksJsonAr);
    combinedBooksJson.addAll(booksJsonEn);
    return combinedBooksJson;
  }
}
