import 'dart:math';

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
  CityBloc({required this.apiController}) : super(CityInitial()) {
    on<FetchCity>((event, emit) async {
      emit(CityLoading());
      try {
        final response = await apiController.getCities(endPoint: '/countries/state/cities/q?country=${event.countryCode}&state=${event.stateCode}'
        );

        if (response.statusCode == 200) {

          final List data = response.data['data'];

          if (data.isNotEmpty) {
            emit(CitySuccess(cityList: data));
          } else {
            emit(CityFail(errorMessage: "No cities found for this state"));
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
