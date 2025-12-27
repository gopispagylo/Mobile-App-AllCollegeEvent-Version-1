import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'event_list_event.dart';
part 'event_list_state.dart';

class EventListBloc extends Bloc<EventListEvent, EventListState> {
  final ApiController apiController;
  final List<dynamic> eventList = [];
  EventListBloc({required this.apiController}) : super(EventListInitial()) {
    on<FetchEventList>((event, emit) async{

      emit(EventListLoading());

      try{

        // --------- set a base url -------
        await apiController.setBaseUrl();

        final parameter = {
          "" : ""
        };

        final response = await apiController.getMethod(endPoint: 'events', token: "token", data: parameter);
        print("EventListBlocEventListBlocEventListBlocEventListBlocEventListBloc$response");
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            eventList.clear();
            eventList.addAll(responseBody['data']);
            emit(EventSuccess(eventList: List.from(eventList)));
          }else{
            emit(EventFail(errorMessage: responseBody['message']));
          }
        }

      }on DioException catch(e){
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(EventFail(errorMessage: error));
      } catch(e){
        emit(EventFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}