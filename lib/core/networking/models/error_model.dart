import 'package:dio/dio.dart';

class Failure{
  final ErrorModel error;

  Failure({required this.error});

  factory Failure.fromApi(dynamic error){
    if(error is DioException){
      return Failure(error: ErrorModel.fromJson(error.response?.data));
    }
    return Failure(error: ErrorModel.fromJson(error));
  }

}


class ErrorModel {
  ErrorModel({
    required this.status,
    required this.message,
  });

  final String? status;
  final String? message;

  factory ErrorModel.fromJson(Map<String, dynamic> json){
    return ErrorModel(
      status: json["status"],
      message: json["message"],
    );
  }

}
