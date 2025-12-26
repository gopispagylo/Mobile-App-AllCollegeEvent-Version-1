import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'user_update_event.dart';
part 'user_update_state.dart';

class UserUpdateBloc extends Bloc<UserUpdateEvent, UserUpdateState> {
  final ApiController apiController;
  UserUpdateBloc({required this.apiController}) : super(UserUpdateInitial()) {
    on<ClickUserUpdate>((event, emit) async{
      emit(UserUpdateLoading());
      try{

        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ----- access token data base -------
        final token = await DBHelper().getToken();

        // ----- get a user id -----
        final userId = await DBHelper().getUserId();

        // -------- Build request body --------
        final Map<String, dynamic> parameter = {};

        if (event.name.trim().isNotEmpty) {
          parameter['name'] = event.name.trim();
        }
        if (event.state.trim().isNotEmpty) {
          parameter['state'] = event.state.trim();
        }
        if (event.city.trim().isNotEmpty) {
          parameter['city'] = event.city.trim();
        }
        if (event.country.trim().isNotEmpty) {
          parameter['country'] = event.country.trim();
        }
        if (event.phone.trim().isNotEmpty) {
          parameter['phone'] = event.phone.trim();
        }

        print("UserUpdateBlocUserUpdateBlocUserUpdateBlocUserUpdateBlocUserUpdateBloc$parameter");
        final response = await apiController.putMethod(endPoint: 'user/$userId', token: token!, data: parameter);
        print("UserUpdateBlocUserUpdateBlocUserUpdateBlocUserUpdateBlocUserUpdateBloc$response");

        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
          emit(UserUpdateSuccess());
          }else{
            emit(UserUpdateFail(errorMessage: responseBody['message']));
          }
        }
      }on DioException catch(e){
        // ------ error handle config --------
      final errorMessage =  HandleErrorConfig().handleDioError(e);
      emit(UserUpdateFail(errorMessage: errorMessage));

      } catch(e){
        emit(UserUpdateFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
