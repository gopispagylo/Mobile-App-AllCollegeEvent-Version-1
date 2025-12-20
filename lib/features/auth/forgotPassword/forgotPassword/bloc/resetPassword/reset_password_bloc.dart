import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ApiController apiController;
  ResetPasswordBloc({required this.apiController}) : super(ResetPasswordInitial()) {
    on<ClickedResetPassword>((event, emit) async{
      emit(ResetPasswordLoading());
      try{

        // ------- trigger the base url --------
        await apiController.setBaseUrl();

        final parameter = {
          'email' : event.email,
          'password' : event.password
        };
        print("ResetPasswordBlocResetPasswordBlocResponseResetPasswordBlocResetPasswordBlocResponse$parameter");
        final response = await apiController.postMethod(endPoint: "auth/reset-password", data: parameter);
        print("ResetPasswordBlocResetPasswordBlocResponseResetPasswordBlocResetPasswordBlocResponse$response");
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            emit(ResetPasswordSuccess());
          }else{
            emit(ResetPasswordFail(errorMessage: responseBody['message']));
          }
        }
      }on DioException catch(e){
        if(e.type == DioExceptionType.connectionError || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout){
          emit(ResetPasswordFail(errorMessage: ConfigMessage().noInterNetMsg));
        }else{
          emit(ResetPasswordFail(errorMessage: ConfigMessage().somethingWentWrongMsg));
        }
      } catch(e){
        emit(ResetPasswordFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
