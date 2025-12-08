import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiController apiController;
  LoginBloc({required this.apiController}) : super(LoginInitial()) {
    on<ClickedLogin>((event, emit) async{
      emit(LoginLoading());
      try{
        // Giving a body
        final parameter = {
          "email": event.email,
          "password": "${event.password}",
          "type": event.type
        };
        print("parameterparameterparameterparameter$parameter");
        final response = await apiController.postMethod(endPoint: "http://13.204.5.72:5000/api/v1/auth/login", data: parameter);
        print("responseresponseresponseresponseresponse$response");
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            emit(LoginSuccess());
          }else{
            print("responseBodyresponseBodyresponseBody$responseBody");
          }
        }
      } on DioException catch(e){
        if(e.type == DioExceptionType.connectionError || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout){
          emit(LoginFail(errorMessage: "No internet connection"));
        }else{
          emit(LoginFail(errorMessage: "Something went wrong, please try again$e"));
        }
      } catch(e){
        emit(LoginFail(errorMessage: "Unexpected error occurred"));
      }
    });
  }
}
