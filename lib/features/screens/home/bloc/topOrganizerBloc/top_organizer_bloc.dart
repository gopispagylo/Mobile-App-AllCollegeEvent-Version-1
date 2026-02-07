import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'top_organizer_event.dart';
part 'top_organizer_state.dart';

class TopOrganizerBloc extends Bloc<TopOrganizerEvent, TopOrganizerState> {
  final ApiController apiController;
  final List<dynamic> topOrganizerList = [];
  TopOrganizerBloc({required this.apiController})
    : super(TopOrganizerInitial()) {
    on<FetchTopOrganizer>((event, emit) async {
      emit(TopOrganizerLoading());

      try {
        print('jhsjhdshjkdsjhdsjhdsjhdsjhdsajhadsjhadsjhasdjhadssadjh');

        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ------------ get a token ---------
        final token = await DBHelper().getToken();

        print("tokentokentokentokentokentokentoken$token");

        final response = await apiController.getMethodWithoutBodyAndHeader(
          endPoint: 'organizations/',
        );

        print(
          "TopOrganizerBlocTopOrganizerBlocTopOrganizerBlocTopOrganizerBloc$response",
        );

        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            topOrganizerList.clear();
            topOrganizerList.addAll(responseBody['data']);
            emit(
              TopOrganizerSuccess(topOrganizer: List.from(topOrganizerList)),
            );
          } else {
            emit(TopOrganizerFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        print(
          "TopOrganizerBlocTopOrganizerBlocTopOrganizerBlocTopOrganizerBloc$e",
        );

        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(TopOrganizerFail(errorMessage: error));
      } catch (e) {
        print(
          "TopOrganizerBlocTopOrganizerBlocTopOrganizerBlocTopOrganizerBloc$e",
        );
        emit(
          TopOrganizerFail(errorMessage: ConfigMessage().unexpectedErrorMsg),
        );
      }
    });
  }
}
