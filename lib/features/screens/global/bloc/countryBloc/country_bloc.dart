import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final ApiController apiController;
  List<dynamic> countryList = [];
  CountryBloc({required this.apiController}) : super(CountryInitial()) {
    on<FetchCountry>((event, emit) async {
      emit(CountryLoading());
      try {
        // ----------- initial set base url -------------
        await apiController.setBaseUrl();

        final response = await apiController.getMethodWithoutBodyAndHeader(
          endPoint: "location/countries",
        );

        if (response.statusCode == 200) {
          final responseBody = response.data!;
          if (responseBody['status'] == true) {
            countryList.clear();
            countryList.addAll(responseBody['data']);
            if (countryList.isNotEmpty) {
              emit(CountrySuccess(countryList: List.from(countryList)));
            } else {
              emit(CountryFail(errorMessage: "No cities found"));
            }
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(CountryFail(errorMessage: error));
      } catch (e) {
        emit(CountryFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
