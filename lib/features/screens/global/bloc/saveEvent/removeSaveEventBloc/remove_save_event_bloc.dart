import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'remove_save_event_event.dart';
part 'remove_save_event_state.dart';

class RemoveSaveEventBloc extends Bloc<RemoveSaveEventEvent, RemoveSaveEventState> {
  final ApiController apiController;
  final Map<String, bool> checkSave = {};
  RemoveSaveEventBloc({required this.apiController}) : super(RemoveSaveEventInitial()) {
    on<ClickRemoveSaveEvent>((event, emit) async{

      emit(RemoveSaveEventLoading(eventId: event.eventId));

      try {

        await apiController.setBaseUrl();

        // ------- token --------
        final token = await DBHelper().getToken();

        // ------- user or org id --------
        final userId = await DBHelper().getUserId();

        final params = {
          "eventIdentity": event.eventId,
          "userIdentity": userId
        };

        // --------- initial save toggle --------
        final newSave = !(checkSave[event.eventId] ?? false);

        checkSave[event.eventId] = newSave;

        emit(AddSave(eventId: event.eventId, checkSave: newSave));

        final response = await apiController.postMethodWithHeader(endPoint: 'events/save', token: token!, data: params);

        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            emit(RemoveSaveEventSuccess(successMessage: responseBody['message']));
          } else{
            emit(RemoveSaveEventFail(errorMessage: responseBody['message'], eventId: event.eventId));
          }
        }
      } on DioException catch (e) {
        final error = HandleErrorConfig().handleDioError(e);
        emit(RemoveSaveEventFail(errorMessage: error, eventId: event.eventId));
      } catch (e) {
        emit(RemoveSaveEventFail(
          errorMessage: ConfigMessage().unexpectedErrorMsg, eventId: event.eventId,
        ));
      }
    });
  }
}
