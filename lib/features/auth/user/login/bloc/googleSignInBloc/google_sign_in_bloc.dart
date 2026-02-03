import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
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
      emit(GoogleSignInLoading());

      try {
        DBHelper db = DBHelper();

        await apiController.setBaseUrl();

        final parameter = {'googleToken': event.googleToken};

        final response = await apiController.postMethod(
          endPoint: 'auth/google-login',
          data: parameter,
        );

        if (response.statusCode == 200) {
          final responseBody = response.data;

          if (responseBody['status'] == true) {
            // --------- insert the bool value on the sqLite data base ------------
            await db.insertIsLogin("isLogin", true);

            await db.insertingIsSplash('isSplash', true);

            // ------- set token ---------
            await db.insertToken(responseBody['token']);

            final token = await db.getToken();

            print("tokentokentokentokentokentokentokentokentokentoken$token");

            // -------- set a user id --------
            await db.insertUserId(responseBody['data']['identity']);

            // ------- set user name -----
            await db.insertUserDetails(
              responseBody['data']['name'],
              responseBody['data']['email'],
            );

            emit(GoogleSignInSuccess());
          } else {
            print("errorerrorerrorerrorerrorerrorerrorerrorerror");
            emit(GoogleSignInFail(errorMessage: responseBody['message']));
          }
        } else {
          print("errorerrorerrorerrorerrorerrorerrorerrorerror");
          emit(GoogleSignInFail(errorMessage: ConfigMessage().serverError));
        }
      } on DioException catch (e) {
        print("errorerrorerrorerrorerrorerrorerrorerrorerror$e");
        final error = HandleErrorConfig().handleDioError(e);
        emit(GoogleSignInFail(errorMessage: error));
      } catch (e) {
        print("errorerrorerrorerrorerrorerrorerrorerrorerror$e");
        emit(
          GoogleSignInFail(errorMessage: ConfigMessage().unexpectedErrorMsg),
        );
      }
    });
  }
}
