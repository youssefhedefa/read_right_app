import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteDataSource{

  final supabase = Supabase.instance.client;
  final String bucket = 'test_audio';
  final String audioSchema = 'public/';
  final String audioExtension = '.wav';
  final String imageSchema = 'images/';
  final String imageExtension = '.png';

  Future<dynamic> storeAudioToAudioBucket(String path) async {
    final avatarFile = File(path);
    String fileName = '$audioSchema${DateTime.now().millisecondsSinceEpoch}$audioExtension';
    final String fullPath = await supabase.storage.from(bucket).upload(
      fileName,
      avatarFile,
      fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
    );
    return fetchAudioFromAudioBucket(fullPath);
  }

  Future<dynamic> storeImageToBucket(String path) async {
    final avatarFile = File(path);
    String fileName = '$imageSchema${DateTime.now().millisecondsSinceEpoch}$imageExtension';
    final String fullPath = await supabase.storage.from(bucket).upload(
      fileName,
      avatarFile,
      fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
    );
    return fetchImageFromBucket(fullPath);
  }

  fetchAudioFromAudioBucket(String fileName) async{
    final response = supabase.storage.from(bucket).getPublicUrl(fileName);
    return response;
  }

  fetchImageFromBucket(String fileName) async{
    final response = supabase.storage.from(bucket).getPublicUrl(fileName);
    return response;
  }

}