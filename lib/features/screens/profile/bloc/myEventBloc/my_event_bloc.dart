import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'my_event_event.dart';

part 'my_event_state.dart';

class MyEventBloc extends Bloc<MyEventEvent, MyEventState> {
  final ApiController apiController;
  final List<dynamic> myEventList = [];

  MyEventBloc({required this.apiController}) : super(MyEventInitial()) {
    on<FetchMyEvent>((event, emit) async {
      emit(MyEventLoading());

      try {

        // --------- set a base url ----------
        await apiController.setBaseUrl();

        // ---------- get a user id ----------
        final userId = await DBHelper().getUserId();
        final token = await DBHelper().getToken();

        final response = await apiController.getMethodWithoutBody(
          endPoint: 'organization/$userId/events',
          token: token!,
        );
        print(
          "MyEventBlocMyEventBlocMyEventBlocMyEventBlocMyEventBlocMyEventBloc$response",
        );
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            myEventList.clear();
            myEventList.addAll(responseBody['data']);
            if (responseBody['data'].isNotEmpty) {
              emit(MyEventSuccess(myEvent: List.from(myEventList)));
            } else {
              emit(MyEventFail(errorMessage: "No data found"));
            }
          } else {
            emit(MyEventFail(errorMessage: responseBody['message']));
          }
        } else {
          emit(MyEventFail(errorMessage: ConfigMessage().serverError));
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(MyEventFail(errorMessage: error));
      } catch (e) {
        emit(MyEventFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
