import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final ApiController apiController;
  List<dynamic> cityList = [];
  CityBloc({required this.apiController}) : super(CityInitial()) {
    on<FetchCity>((event, emit) async {
      emit(CityLoading());
      try {
        // ----------- initial set base url -------------
        await apiController.setBaseUrl();

        final response = await apiController.getMethodWithoutBodyAndHeader(
          endPoint: 'location/states/${event.stateCode}/cities',
        );

        if (response.statusCode == 200) {
          final responseBody = response.data!;
          if (responseBody['status'] == true) {
            cityList.clear();
            cityList.addAll(responseBody['data']);
            if (cityList.isNotEmpty) {
              emit(CitySuccess(cityList: cityList));
            } else {
              emit(CityFail(errorMessage: "No cities found for this state"));
            }
          }
        } else {
          emit(CityFail(errorMessage: "Server error: ${response.statusCode}"));
        }
      } on DioException catch (e) {
        final error = HandleErrorConfig().handleDioError(e);
        emit(CityFail(errorMessage: error));
      } catch (e) {
        emit(CityFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
