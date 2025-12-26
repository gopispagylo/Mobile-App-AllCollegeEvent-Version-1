import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'org_acc_creation_event.dart';
part 'org_acc_creation_state.dart';

class OrgAccCreationBloc extends Bloc<OrgAccCreationEvent, OrgAccCreationState> {
  final ApiController apiController;
  OrgAccCreationBloc({required this.apiController}) : super(OrgAccCreationInitial()) {
    on<ClickedOrgSignUp>((event, emit) async{
      emit(OrgSignUpLoading());

      try{

        // ------ set a base url --------
        await apiController.setBaseUrl();

        // ----- access the data base ------
        DBHelper db = DBHelper();

        // Giving a body
        final parameter = {
          "email": event.email,
          "password": event.password,
          "type": event.type,
          "org_name": event.orgName,
          "org_cat": event.orgCat,
          "country": event.country,
          "state": event.state,
          "city": event.city,
          'platform' : 'mobile'
        };

        print("parameterparameterparameterparameterForOrgAccCreationBloc$parameter");

        // Initial set base url
        await apiController.setBaseUrl();
        final response = await apiController.postMethod(endPoint: "auth/signup", data: parameter);
        print("OrgAccCreationBlocOrgAccCreationBlocOrgAccCreationBlocOrgAccCreationBloc$response");
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){

            // -------- set a user id --------
            await db.insertUser(responseBody['identity']);

            emit(OrgSignUpSuccess());
          }else {
            emit(OrgSignUpFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch(e){
        // ------ error handle config --------
        HandleErrorConfig().handleDioError(e);
      } catch(e){
        print('OrgAccCreationBlocOrgAccCreationBlocOrgAccCreationBlocOrgAccCreationBloc$e');
        emit(OrgSignUpFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
