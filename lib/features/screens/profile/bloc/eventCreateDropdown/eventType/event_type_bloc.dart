import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'event_type_event.dart';
part 'event_type_state.dart';

class EventTypeBloc extends Bloc<EventTypeEvent, EventTypeState> {
  final ApiController apiController;
  final List<dynamic> eventTypeList = [];
  EventTypeBloc({required this.apiController}) : super(EventTypeInitial()) {
    on<ClickedEventType>((event, emit) async {
      emit(EventTypeLoading());
      try {
        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ----- access token data base -------
        final token = await DBHelper().getToken();

        final response = await apiController.getMethodWithoutBody(
          endPoint: 'master/event-types/${event.identity}',
          token: token!,
        );
        print(
          "EventTypeBlocEventTypeBlocEventTypeBlocEventTypeBlocEventTypeBlocEventTypeBlocEventTypeBloc$response",
        );
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['success'] == true) {
            eventTypeList.clear();
            eventTypeList.addAll(responseBody['data']);
            emit(
              EventTypeSuccess(
                eventTypeList: List.from(eventTypeList),
              ),
            );
            print("kjsjdfgjkfhksdjhsdkjsdkjsdjksjdkgdsjkgdjkgdsjkdsf$eventTypeList");
          } else {
            emit(EventTypeFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(EventTypeFail(errorMessage: error));
      } catch (e) {
        emit(
          EventTypeFail(errorMessage: ConfigMessage().unexpectedErrorMsg),
        );
      }
    });
  }
}
