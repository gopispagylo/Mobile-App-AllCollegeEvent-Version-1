import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'choose_state_event.dart';
part 'choose_state_state.dart';

class ChooseStateBloc extends Bloc<ChooseStateEvent, ChooseStateState> {
  final ApiController apiController;
  ChooseStateBloc({required this.apiController}) : super(ChooseStateInitial()) {
    on<FetchChooseState>((event, emit) async {
      emit(ChooseStateLoading());

      try {
        final response = await apiController.getStates(
          endPoint: '/countries/states',
          data: {'country': 'India'}, // "India"
        );

        if (response.statusCode == 200) {
          final List countries = response.data['data'];

          // Find selected country
          final country = countries.firstWhere(
                (c) => c['name'] == event.countryCode,
            orElse: () => null,
          );

          if (country != null && country['states'] != null) {
            emit(ChooseStateSuccess(
              stateList: country['states']
            ));
          } else {
            emit(ChooseStateFail(errorMessage: "No states found"));
          }
        }
      } on DioException catch (e) {
        print("DioExceptionDioExceptionDioExceptionDioException$e");
        final error = HandleErrorConfig().handleDioError(e);
        emit(ChooseStateFail(errorMessage: error));
      } catch (e) {
        print("DioExceptionDioExceptionDioExceptionDioException$e");
        emit(ChooseStateFail(
          errorMessage: ConfigMessage().unexpectedErrorMsg,
        ));
      }
    });
  }
}
