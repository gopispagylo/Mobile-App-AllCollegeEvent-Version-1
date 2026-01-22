import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'saved_event_event.dart';
part 'saved_event_state.dart';

class SavedEventBloc extends Bloc<SavedEventEvent, SavedEventState> {
  final ApiController apiController;
  final List<dynamic> savedEventList = [];
  SavedEventBloc({required this.apiController}) : super(SavedEventInitial()) {
    on<FetchSavedEvent>((event, emit) async{

      emit(SavedEventLoading());

      try{

        // --------- set a base url -------
        await apiController.setBaseUrl();

        // --------- get a user or org id ----------
        final userId = await DBHelper().getUserId();

        // ------------- token ---------------
        final token = await DBHelper().getToken();

        final response = await apiController.getMethodWithoutBody(endPoint: 'user/saved/$userId', token: token!,);

        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            savedEventList.clear();
            savedEventList.addAll(responseBody['data']['events']);
            if(responseBody['data']['events'].isNotEmpty){
              emit(SavedEventSuccess(savedEventList: List.from(savedEventList)));
            }else{
              emit(SavedEventFail(errorMessage: "No data found"));
            }
          }else{
            emit(SavedEventFail(errorMessage: responseBody['message']));
          }
        }

      }on DioException catch(e){

        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(SavedEventFail(errorMessage: error));

      } catch(e){
        emit(SavedEventFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
