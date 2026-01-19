import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  final ApiController apiController;
  final List<dynamic> eventDetailList = [];
  EventDetailBloc({required this.apiController}) : super(EventDetailInitial()) {
    on<ClickEventDetail>((event, emit) async{

      emit(EventDetailLoading());

      try{

        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ----- access token data base -------
        final token = await DBHelper().getToken();


        final parameter = {
          "" : ""
        };

        final response = await apiController.getMethod(endPoint: 'events/${event.identity}', token: token!, data: parameter);
        print('werwertertytrytyuyutuyiuyiuiytyuytrytrtre$response');
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            eventDetailList.clear();
            eventDetailList.add(responseBody['data']);
            emit(EventDetailSuccess(eventDetailList: List.from(eventDetailList)));
          }else{
            emit(EventDetailFail(errorMessage: responseBody['message']));
          }
        }

      }on DioException catch(e){
        // ------ error handle config --------
        HandleErrorConfig().handleDioError(e);
      } catch(e){
        emit(EventDetailFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
