import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'accommodation_event.dart';

part 'accommodation_state.dart';

class AccommodationBloc extends Bloc<AccommodationEvent, AccommodationState> {
  final ApiController apiController;
  final List<dynamic> accommodationList = [];

  AccommodationBloc({required this.apiController})
    : super(AccommodationInitial()) {
    on<FetchAccommodation>((event, emit) async {
      emit(AccommodationLoading());
      try {
        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ----- access token data base -------
        final token = await DBHelper().getToken();

        final response = await apiController.getMethodWithoutBody(
          endPoint: 'master/accommodations',
          token: token!,
        );
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            accommodationList.clear();
            accommodationList.addAll(responseBody['data']);
            emit(
              AccommodationSuccess(
                accommodationList: List.from(accommodationList),
              ),
            );
          } else {
            emit(AccommodationFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(AccommodationFail(errorMessage: error));
      } catch (e) {
        emit(
          AccommodationFail(errorMessage: ConfigMessage().unexpectedErrorMsg),
        );
      }
    });
  }
}
