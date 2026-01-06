import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiController apiController;

  LoginBloc({required this.apiController}) : super(LoginInitial()) {
    on<ClickedLogin>((event, emit) async {
      emit(LoginLoading());

      try {
        DBHelper db = DBHelper();

        // Giving a body
        final parameter = {
          "email": event.email,
          "password": event.password,
          "type": event.type,
        };

        // Initial set base url
        await apiController.setBaseUrl();
        final response = await apiController.postMethod(
          endPoint: "auth/login",
          data: parameter,
        );
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            emit(LoginSuccess());

            // --------- insert the bool value on the sqLite data base ------------
            await db.insertIsLogin("isLogin", true);
            await db.insertingIsSplash('isSplash', true);

            // ------- set token ---------
            await db.insertToken(responseBody['token']);

            // -------- set a user id --------
            await db.insertUserId(responseBody['data']['identity']);
          } else {
            emit(LoginFail(errorMessage: responseBody['message']));
          }
        } else {
          emit(LoginFail(errorMessage: ConfigMessage().serverError));
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(LoginFail(errorMessage: error));
      } catch (e) {
        emit(LoginFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
