import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yaml/yaml.dart';

class ApiController {

  Future<void> setBaseUrl() async{
    dio.options.baseUrl = await getBaseUrl();
    print('jhfzdmfhxfmhsfmghsdmfhgdsfnhgsdfhsgdfnhg${dio.options.baseUrl}');
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: "",
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    )
  );

  // Post Method
  Future<Response> postMethod({required String endPoint, required Map<String,dynamic> data}) async{
    final response = await dio.post(endPoint,data: data);
    return response;
  }

  // Post Method with header
  Future<Response> postMethodWithHeader({required String endPoint, required String token, required Map<String,dynamic> data}) async{
    final response = await dio.post(endPoint,data: data,options: Options(headers: {
      "token" : token
    }));
    return response;
  }

  // Get Method
  Future<Response> getMethod({required String endPoint,required String token, required Map<String,dynamic> data}) async{
    final response = await dio.get(endPoint,data: data,options: Options(
      headers: {
        "token" : token
      }
    ));
    return response;
  }
}


  // Dynamically dev to prod url changed
  Future<String> getBaseUrl() async{

  // Android setup
 if(Platform.isAndroid){
   // Get a file of pubspec yaml file.
   final yamlFile = await rootBundle.loadString('pubspec.yaml');
   final versionName = loadYaml(yamlFile)['version'] ?? '';
   if(versionName.contains('beta')){
     return dotenv.env['DEV_URL']!;
   }else{
     return dotenv.env['PROD_URL']!;
   }
 }

  // IOS setup
  if(Platform.isIOS){
    // Get a file of pubspec yaml file.
    final yamlString = await rootBundle.loadString('pubspec.yaml');
    final yamlVersion = loadYaml(yamlString)['version'] ?? '';

    if(yamlVersion.contanins('beta')){
      return dotenv.env['DEV_URL']!;
    }else{
      return dotenv.env['PROD_URL']!;
    }
  }

  return dotenv.env['PROD_URL']!;
}