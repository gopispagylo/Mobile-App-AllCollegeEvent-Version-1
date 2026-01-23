import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'event_count_update_event.dart';
part 'event_count_update_state.dart';

class EventCountUpdateBloc extends Bloc<EventCountUpdateEvent, EventCountUpdateState> {
  final ApiController apiController;
  EventCountUpdateBloc({required this.apiController}) : super(EventCountUpdateInitial()) {
    on<ClickEventCountUpdate>((event, emit) async{
      emit(EventCountUpdateLoading());
      try{

        // set initial set base url
        await apiController.setBaseUrl();

        final params ={
          "" : ""
        };
        final response = await apiController.postMethod(endPoint: "events/${event.slug}/view", data: params);
        print("EventCountUpdateBlocEventCountUpdateBlocEventCountUpdateBlocEventCountUpdateBloc$response");
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody["status"] == true){
            emit(EventCountUpdateSuccess());
          }else{
            print("knfdsjkdfsjkdfjdfjhkdfs");
            emit(EventCountUpdateFail(errorMessage: ConfigMessage().somethingWentWrongMsg));
          }
        }else{
          emit(EventCountUpdateFail(errorMessage: ConfigMessage().somethingWentWrongMsg));
        }
      } on DioException catch(e){
        print("DioExceptionDioExceptionDioException$e");
        final error = HandleErrorConfig().handleDioError(e);
        emit(EventCountUpdateFail(errorMessage: error));
      } catch (e){
        emit(EventCountUpdateFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
