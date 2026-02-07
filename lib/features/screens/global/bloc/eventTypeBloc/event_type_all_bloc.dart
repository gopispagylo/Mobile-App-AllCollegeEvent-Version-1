import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'event_type_all_event.dart';
part 'event_type_all_state.dart';

class EventTypeAllBloc extends Bloc<EventTypeAllEvent, EventTypeAllState> {
  final ApiController apiController;
  final List<dynamic> eventTypeList = [];
  EventTypeAllBloc({required this.apiController})
    : super(EventTypeAllInitial()) {
    on<EventTypeAll>((event, emit) async {
      emit(EventTypeAllLoading());

      try {
        // --------- set a base url -------
        await apiController.setBaseUrl();

        final response = await apiController.getMethodWithoutBodyAndHeader(
          endPoint: 'master/event-types',
        );
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            eventTypeList.clear();
            eventTypeList.addAll(responseBody['data']);
            emit(EventTypeSuccessAll(eventTypeList: List.from(eventTypeList)));
          } else {
            emit(EventTypeFailAll(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(EventTypeFailAll(errorMessage: error));
      } catch (e) {
        emit(
          EventTypeFailAll(errorMessage: ConfigMessage().unexpectedErrorMsg),
        );
      }
    });
  }
}
