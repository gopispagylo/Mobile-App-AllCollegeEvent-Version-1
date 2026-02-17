import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'trending_event_list_event.dart';
part 'trending_event_list_state.dart';

class TrendingEventListBloc
    extends Bloc<TrendingEventListEvent, TrendingEventListState> {
  final ApiController apiController;
  final List<dynamic> trendingEventList = [];

  int page = 1;
  final int limit = 2;

  bool hasMore = true;
  bool isLoadingMore = false;

  TrendingEventListBloc({required this.apiController})
    : super(TrendingEventListInitial()) {
    on<FetchTrendingEventList>((event, emit) async {
      if (!event.loadMore) {
        page = 1;
        hasMore = true;
        trendingEventList.clear();
        emit(TrendingEventListLoading());
      } else {
        if (isLoadingMore || !hasMore) return;
        isLoadingMore = true;
        page++;
      }

      try {
        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ------- token -------
        final token = await DBHelper().getToken();

        final response = event.isLogin
            ? await apiController.getMethodWithoutBody(
                endPoint:
                    'trending_events?offset=${(page - 1) * limit}&limit=$limit',
                token: token!,
              )
            : await apiController.getMethodWithoutBodyAndHeader(
                endPoint:
                    'trending_events?offset=${(page - 1) * limit}&limit=$limit',
              );

        print(
          "TrendingEventListEventTrendingEventListEventTrendingEventListEvent$response",
        );

        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            trendingEventList.addAll(responseBody['data']);
            hasMore = responseBody['data'].length == limit;
            isLoadingMore = false;

            emit(
              TrendingEventListSuccess(
                trendingEventList: List.from(trendingEventList),
                hasMore: hasMore,
              ),
            );
          } else {
            emit(TrendingEventListFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(TrendingEventListFail(errorMessage: error));
      } catch (e) {
        emit(
          TrendingEventListFail(
            errorMessage: ConfigMessage().unexpectedErrorMsg,
          ),
        );
      }
    });
  }
}
