import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final ApiController apiController;
  final List<dynamic> userProfileList = [];
  UserProfileBloc({required this.apiController}) : super(UserProfileInitial()) {
    on<ClickedUserProfile>((event, emit) async{

      emit(UserProfileLoading());

      try{

        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ----- access token data base -------
        final token = await DBHelper().getToken();

        // ----- get a user id -----
        final userId = await DBHelper().getUserId();

        final response = await apiController.getMethodWithoutBody(endPoint: 'admin/users/$userId', token: token!);

        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            userProfileList.clear();
            userProfileList.add(responseBody['data']);
            emit(UserProfileSuccess(userProfileList: List.from(userProfileList)));
          }else{
            emit(UserProfileFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch(e){
        // ------ error handle config --------
        HandleErrorConfig().handleDioError(e);
      } catch(e){
        emit(UserProfileFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
