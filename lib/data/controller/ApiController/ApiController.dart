import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yaml/yaml.dart';

class ApiController {
  final dio = Dio(
    BaseOptions(
      baseUrl: "",
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      // sendTimeout: Duration(seconds: 5)
    ),
  );

  // Assign the value of base url
  Future<void> setBaseUrl() async {
    dio.options.baseUrl = await getBaseUrl();
  }

  // ------------ Post Method -----------
  Future<Response> postMethod({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    final response = await dio.post(endPoint, data: data);
    return response;
  }

  // ------------- Post Method with header -----------
  Future<Response> postMethodWithHeader({
    required String endPoint,
    required String token,
    required Map<String, dynamic> data,
  }) async {
    final response = await dio.post(
      endPoint,
      data: data,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  // ---------- post with out header
  Future<Response> postMethodWithOutHeader({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    final response = await dio.post(endPoint, data: data);
    return response;
  }

  // ---------- post a form data ----------
  Future<Response> postMethodWithFormData({
    required String endPoint,
    required String token,
    required FormData data,
  }) async {
    final response = await dio.post(
      endPoint,
      data: data,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "multipart/form-data",
        },
      ),
    );
    return response;
  }

  // ---------- Get Method ------------
  Future<Response> getMethod({
    required String endPoint,
    required String token,
    required Map<String, dynamic> data,
  }) async {
    final response = await dio.get(
      endPoint,
      data: data,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  // ------------- Get Method without data -----------
  Future<Response> getMethodWithoutBody({
    required String endPoint,
    required String token,
  }) async {
    final response = await dio.get(
      endPoint,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  Future<Response> getMethodWithoutBodyAndHeader({
    required String endPoint,
  }) async {
    final response = await dio.get(endPoint);
    return response;
  }

  // ----------- Put Method with data -------------
  Future<Response> putMethod({
    required String endPoint,
    required String token,
    required Map<String, dynamic> data,
  }) async {
    final response = await dio.put(
      endPoint,
      data: data,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response;
  }

  // -------- put with form data --------
  Future<Response> putMethodWithForm({
    required String endPoint,
    required String token,
    required FormData data,
  }) async {
    final response = await dio.put(
      endPoint,
      data: data,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "multipart/form-data",
        },
      ),
    );
    return response;
  }
}

// Dynamically dev to prod url changed
Future<String> getBaseUrl() async {
  // Android setup
  if (Platform.isAndroid) {
    // Get a file of pubspec yaml file.
    final yamlFile = await rootBundle.loadString('pubspec.yaml');
    final versionName = loadYaml(yamlFile)['version'] ?? '';
    if (versionName.contains('beta')) {
      return dotenv.env['DEV_URL']!;
    } else {
      return dotenv.env['PROD_URL']!;
    }
  }

  // IOS setup
  if (Platform.isIOS) {
    // Get a file of pubspec yaml file.
    final yamlString = await rootBundle.loadString('pubspec.yaml');
    final yamlVersion = loadYaml(yamlString)['version'] ?? '';

    if (yamlVersion.contains('beta')) {
      return dotenv.env['DEV_URL']!;
    } else {
      return dotenv.env['PROD_URL']!;
    }
  }

  return dotenv.env['PROD_URL']!;
}
