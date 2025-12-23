import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
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
    on<ClickedLogin>((event, emit) async{
      emit(LoginLoading());

      try{

        DBHelper db = DBHelper();

        // Giving a body
        final parameter = {
          "email": event.email,
          "password": event.password,
          "type": event.type
        };

        // Initial set base url
        await apiController.setBaseUrl();
        final response = await apiController.postMethod(endPoint: "auth/login", data: parameter);
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            emit(LoginSuccess());

            // --------- insert the bool value on the sqLite data base ------------
            await db.insertIsLogin("isLogin", true);
            await db.insertingIsSplash('isSplash', true);

          }else {
            emit(LoginFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch(e){
        if(e.type == DioExceptionType.connectionError || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout){
          emit(LoginFail(errorMessage: ConfigMessage().noInterNetMsg));
        }else{
          emit(LoginFail(errorMessage: ConfigMessage().somethingWentWrongMsg));
        }
      } catch(e){
        emit(LoginFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
