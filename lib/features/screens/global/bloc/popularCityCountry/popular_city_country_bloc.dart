import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'popular_city_country_event.dart';
part 'popular_city_country_state.dart';

class PopularCityCountryBloc
    extends Bloc<PopularCityCountryEvent, PopularCityCountryState> {
  final ApiController apiController;
  final Map<String, dynamic> cityCountryList = {};
  PopularCityCountryBloc({required this.apiController})
    : super(PopularCityCountryInitial()) {
    on<FetchPopularCityCountry>((event, emit) async {
      emit(LoadingPopularCityCountry());

      try {
        // initial set a base url
        await apiController.setBaseUrl();

        final response = await apiController.getMethodWithoutBodyAndHeader(
          endPoint: "analytics/location-counts",
        );
        print(
          "PopularCityCountryBlocPopularCityCountryBlocPopularCityCountryBlocPopularCityCountryBloc$response",
        );
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            cityCountryList.clear();
            cityCountryList.addAll(responseBody['data']);
            if (responseBody['data'].isNotEmpty) {
              emit(SuccessPopularCityCountry(cityCountryList: cityCountryList));
            } else {
              emit(FailPopularCityCountry(errorMessage: "No data found"));
            }
          } else {
            emit(FailPopularCityCountry(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(FailPopularCityCountry(errorMessage: error));
      } catch (e) {
        emit(
          FailPopularCityCountry(
            errorMessage: ConfigMessage().unexpectedErrorMsg,
          ),
        );
      }
    });
  }
}
