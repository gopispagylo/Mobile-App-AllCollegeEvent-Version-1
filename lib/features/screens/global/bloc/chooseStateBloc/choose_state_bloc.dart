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
  List<dynamic> stateList = [];
  ChooseStateBloc({required this.apiController}) : super(ChooseStateInitial()) {
    on<FetchChooseState>((event, emit) async {
      emit(ChooseStateLoading());

      try {

        // ----------- initial set base url -------------
        await apiController.setBaseUrl();


        final response = await apiController.getMethodWithoutBody(
          endPoint: 'location/countries/${event.countryCode}/states',
          token: "", // "India"
        );

        if (response.statusCode == 200) {
          final responseBody = response.data!;
          if(responseBody['status'] == true){
            stateList.clear();
            stateList.addAll(responseBody['data']);
            if (stateList.isNotEmpty) {
              emit(ChooseStateSuccess(
                  stateList: List.from(stateList)
              ));
            } else {
              emit(ChooseStateFail(errorMessage: "No states found"));
            }
          }

        }
      } on DioException catch (e) {
        final error = HandleErrorConfig().handleDioError(e);
        emit(ChooseStateFail(errorMessage: error));
      } catch (e) {
        emit(ChooseStateFail(
          errorMessage: ConfigMessage().unexpectedErrorMsg,
        ));
      }
    });
  }
}
