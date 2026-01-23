import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'organizer_detail_event.dart';
part 'organizer_detail_state.dart';

class OrganizerDetailBloc extends Bloc<OrganizerDetailEvent, OrganizerDetailState> {
  final ApiController apiController;
  final List<dynamic> organizerDetailList = [];
  OrganizerDetailBloc({required this.apiController}) : super(OrganizerDetailInitial()) {
    on<ClickOrgDetail>((event, emit) async{

      emit(OrganizerDetailLoading());

      try{

        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ----- access token data base -------
        final token = await DBHelper().getToken();


        final parameter = {
          "" : ""
        };

        final response = await apiController.getMethod(endPoint: 'organizations/${event.slug}/events', token: token!, data: parameter);
        print('werwertertytrytyuyutuyiuyiuiytyuytrytrtre$response');
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            organizerDetailList.clear();

            // --------- array of object comes list then must use for addAll ----------
            organizerDetailList.addAll(responseBody['data']);
            emit(OrganizerDetailSuccess(organizerDetailList: List.from(organizerDetailList)));
          }else{
            emit(OrganizerDetailFail(errorMessage: responseBody['message']));
          }
        }

      }on DioException catch(e){
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(OrganizerDetailFail(errorMessage: error));
      } catch(e){
        emit(OrganizerDetailFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
