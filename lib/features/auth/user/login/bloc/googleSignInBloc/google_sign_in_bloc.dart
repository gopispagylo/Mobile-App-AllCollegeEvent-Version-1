import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'google_sign_in_event.dart';

part 'google_sign_in_state.dart';

class GoogleSignInBloc extends Bloc<GoogleSignInEvent, GoogleSignInState> {
  final ApiController apiController;

  GoogleSignInBloc({required this.apiController})
    : super(GoogleSignInInitial()) {
    on<ClickGoogleSignIn>((event, emit) async {
      try {

        final parameter = {'googleToken': event.googleToken};

        final response = await apiController.postMethod(
          endPoint: 'auth/google-login',
          data: parameter,
        );

        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            emit(GoogleSignInSuccess());
          } else {
            emit(GoogleSignInFail(errorMessage: responseBody['message']));
          }
        } else {
          emit(GoogleSignInFail(errorMessage: ConfigMessage().serverError));
        }
      } on DioException catch (e) {
        final error = HandleErrorConfig().handleDioError(e);
        emit(GoogleSignInFail(errorMessage: error));
      } catch (e) {
        emit(
          GoogleSignInFail(errorMessage: ConfigMessage().unexpectedErrorMsg),
        );
      }
    });
  }
}
