import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'org_login_event.dart';
part 'org_login_state.dart';

class OrgLoginBloc extends Bloc<OrgLoginEvent, OrgLoginState> {
  final ApiController apiController;
  OrgLoginBloc({required this.apiController}) : super(OrgLoginInitial()) {
    on<ClickedOrgLogin>((event, emit) async{
      emit(OrgLoading());

      try{

        // ----- access the data base ------
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
        print("OrgLoginBlocOrgLoginBlocOrgLoginBlocOrgLoginBloc$response");
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){

            // --------- insert the bool value on the sqLite data base ------------
            await db.insertIsLogin("isLogin", true);
            await db.insertingIsSplash('isSplash', true);

            // ------- set token ---------
            await db.insertToken(responseBody['token']);

            // -------- set a user id --------
            await db.insertUserId(responseBody['data']['identity']);

            // ------- set org name -----
            await db.insertUserDetails(responseBody['data']['organizationName'],responseBody['data']['domainEmail']);

            emit(OrgSuccess());
          }else {
            emit(OrgFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch(e){
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(OrgFail(errorMessage: error));
      } catch(e){
        emit(OrgFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
