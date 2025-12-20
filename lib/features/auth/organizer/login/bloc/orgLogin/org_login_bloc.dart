import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
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
            emit(OrgSuccess());
          }else {
            emit(OrgFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch(e){
        if(e.type == DioExceptionType.connectionError || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout){
          emit(OrgFail(errorMessage: ConfigMessage().noInterNetMsg));
        }else{
          emit(OrgFail(errorMessage: ConfigMessage().somethingWentWrongMsg));
        }
      } catch(e){
        emit(OrgFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
