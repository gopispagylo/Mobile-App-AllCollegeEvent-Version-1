import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
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
        // Giving a body
        final parameter = {
          "email": event.email,
          "password": event.password,
          "type": event.type,
          "org_name": event.orgName,
          "org_cat": event.orgCat,
          "country": event.country,
          "state": event.state,
          "city": event.city
        };

        print("parameterparameterparameterparameterForOrgAccCreationBloc$parameter");

        // Initial set base url
        await apiController.setBaseUrl();
        final response = await apiController.postMethod(endPoint: "auth/signup", data: parameter);
        print("OrgAccCreationBlocOrgAccCreationBlocOrgAccCreationBlocOrgAccCreationBloc$response");
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            emit(OrgSignUpSuccess());
          }else {
            emit(OrgSignUpFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch(e){
        if(e.type == DioExceptionType.connectionError || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout){
          emit(OrgSignUpFail(errorMessage: ConfigMessage().noInterNetMsg));
        }else{
          emit(OrgSignUpFail(errorMessage: ConfigMessage().somethingWentWrongMsg));
        }
      } catch(e){
        emit(OrgSignUpFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
