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
  CountryBloc({required this.apiController}) : super(CountryInitial()) {
    on<FetchCountry>((event, emit) async{
      emit(CountryLoading());
      try {
        final response = await apiController.getCountries(endPoint: '/countries/iso');

        if(response.statusCode == 200){
          final data = response.data['data'];
          if(data.isNotEmpty){
            emit(CountrySuccess(countryList: data));
          }else{
            emit(CountryFail(errorMessage: "No cities found"));
          }
        }
      } on DioException catch(e){
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(CountryFail(errorMessage: error));
      } catch(e){
        emit(CountryFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
