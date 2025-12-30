import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'search_event_list_event.dart';
part 'search_event_list_state.dart';

class SearchEventListBloc extends Bloc<SearchEventListEvent, SearchEventListState> {
  final ApiController apiController;
  final List<dynamic> searchEventList = [];
  SearchEventListBloc({required this.apiController}) : super(SearchEventListInitial()) {
    on<FetchSearchEventList>((event, emit) async{

      emit(SearchEventListLoading());

      try{

        // --------- set a base url -------
        await apiController.setBaseUrl();

        final response = await apiController.getMethodWithoutBody(endPoint: 'events', token: "token",);
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            searchEventList.clear();
            searchEventList.addAll(responseBody['data']);
            emit(SearchEventListSuccess(searchEventList: List.from(searchEventList)));
          }else{
            emit(SearchEventListFail(errorMessage: responseBody['message']));
          }
        }

      }on DioException catch(e){

        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(SearchEventListFail(errorMessage: error));

      } catch(e){
        emit(SearchEventListFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
