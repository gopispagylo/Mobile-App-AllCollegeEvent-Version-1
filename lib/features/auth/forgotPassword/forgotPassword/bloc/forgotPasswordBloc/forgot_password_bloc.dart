import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ApiController apiController;
  ForgotPasswordBloc({required this.apiController}) : super(ForgotPasswordInitial()) {
    on<ClickedSendMail>((event, emit) async{
      emit(ForgotPasswordLoading());
      try{
        final parameter = {
          'email' : event.email
        };
        await apiController.setBaseUrl();
        print("ForgotPasswordBlocparameterForgotPasswordBlocparameterForgotPasswordBlocparameter$parameter");
        final response = await apiController.postMethod(endPoint: "auth/forgot-password", data: parameter);
        print("ForgotPasswordBlocRespponseForgotPasswordBlocRespponseForgotPasswordBlocRespponse$response");
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            emit(ForgotPasswordSuccess());
          }else{
            emit(ForgotPasswordFail(errorMessage: responseBody['message']));
          }
        }
      }on DioException catch(e){
        print("DioExceptionDioExceptionDioExceptionDioException$e");
        if(e.type == DioExceptionType.connectionError || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout){
          emit(ForgotPasswordFail(errorMessage: ConfigMessage().noInterNetMsg));
        }else{
          print("DioExceptionDioExceptionDioExceptionDioException$e");
          emit(ForgotPasswordFail(errorMessage: ConfigMessage().somethingWentWrongMsg));
        }
      } catch(e){
        print("DioExceptionDioExceptionDioExceptionDioException$e");
        emit(ForgotPasswordFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
