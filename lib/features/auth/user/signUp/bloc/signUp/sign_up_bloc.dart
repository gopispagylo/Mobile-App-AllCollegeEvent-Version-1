import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final ApiController apiController;
  SignUpBloc({required this.apiController}) : super(SignUpInitial()) {
    on<ClickedSignUp>((event, emit) async{

      emit(SignUpLoading());
      try{

        DBHelper db = DBHelper();

        // Giving a body
        final parameter = {
          "name" : event.name,
          "email": event.email,
          "password": event.password,
          "type": event.type
        };
        print("SignUpBlocSignUpBlocSignUpBlocSignUpBlocSignUpBlocSignUpBloc$parameter");

        // Initial set base url
        await apiController.setBaseUrl();
        final response = await apiController.postMethod(endPoint: "auth/signup", data: parameter);
        print("SignUpBlocSignUpBlocSignUpBlocSignUpBlocSignUpBlocSignUpBloc$response");
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            emit(SignUpSuccess());
            // --------- insert the bool value on the sqLite data base ------------
            await db.insertIsLogin("isLogin", true);
            await db.insertingIsSplash('isSplash', true);
          }else {
            emit(SignUpFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch(e){
        if(e.type == DioExceptionType.connectionError || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout){
          emit(SignUpFail(errorMessage: ConfigMessage().noInterNetMsg));
        }else{
          emit(SignUpFail(errorMessage: ConfigMessage().somethingWentWrongMsg));
        }
      } catch(e){
        emit(SignUpFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
