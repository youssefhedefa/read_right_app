import 'dart:convert';
import 'package:flutter/services.dart';

class HomeLocalDataSource{
  final String booksJsonPath = 'assets/books/books.json';
  Future<List<Map<String, dynamic>>> loadJsonFile() async {
    final String response = await rootBundle.loadString(booksJsonPath);
    final List<Map<String, dynamic>> booksJson = json.decode(response).cast<Map<String, dynamic>>();
    return booksJson;
  }

}