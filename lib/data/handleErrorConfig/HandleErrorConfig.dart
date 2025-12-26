import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:dio/dio.dart';

class HandleErrorConfig{

  String handleDioError(DioException e) {
    // No Internet
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.receiveTimeout) {
      return ConfigMessage().noInterNetMsg;
    }

    // Server responded
    if (e.response != null) {
      final code = e.response!.statusCode;

      if (code == 401) {
        return "Session expired. Please login again";
      }
      else if (code == 404) {
        return "Data not found";
      }
      else if (code! >= 500) {
        return ConfigMessage().serverError;
      }
    }

    return ConfigMessage().somethingWentWrongMsg;
  }

}