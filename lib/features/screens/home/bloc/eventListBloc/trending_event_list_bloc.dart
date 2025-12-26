import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'trending_event_list_event.dart';
part 'trending_event_list_state.dart';

class TrendingEventListBloc extends Bloc<TrendingEventListEvent, TrendingEventListState> {
  final ApiController apiController;
  final List<dynamic> trendingEventList = [];
  TrendingEventListBloc({required this.apiController}) : super(TrendingEventListInitial()) {
    on<FetchTrendingEventList>((event, emit) async{

      emit(TrendingEventListLoading());

      try{

        // --------- set a base url -------
        await apiController.setBaseUrl();

        final parameter = {
          "" : ""
        };

        final response = await apiController.getMethod(endPoint: 'events', token: "token", data: parameter);
        print("EventListBlocEventListBlocEventListBlocEventListBlocEventListBloc$response");
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            trendingEventList.clear();
            trendingEventList.addAll(responseBody['data']);
            emit(TrendingEventListSuccess(trendingEventList: List.from(trendingEventList)));
          }else{
            emit(TrendingEventListFail(errorMessage: responseBody['message']));
          }
        }

      }on DioException catch(e){
        // ------ error handle config --------
        HandleErrorConfig().handleDioError(e);
      } catch(e){
        print("DioExceptionDioExceptionDioExceptionDioExceptionDioException$e");
        emit(TrendingEventListFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
