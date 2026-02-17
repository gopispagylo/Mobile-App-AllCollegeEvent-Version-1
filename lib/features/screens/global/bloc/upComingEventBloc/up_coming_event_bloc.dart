import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'up_coming_event_event.dart';
part 'up_coming_event_state.dart';

class UpComingEventBloc extends Bloc<UpComingEventEvent, UpComingEventState> {
  final ApiController apiController;
  final List<dynamic> upComingEventList = [];

  int page = 1;
  final int limit = 2;

  bool hasMore = true;
  bool isLoadingMore = false;
  UpComingEventBloc({required this.apiController})
    : super(UpComingEventInitial()) {
    on<FetchUpComingEventList>((event, emit) async {
      if (!event.loadMore) {
        page = 1;
        hasMore = true;
        upComingEventList.clear();
        emit(UpComingEventListLoading());
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
                    'upcoming_events?offset=${(page - 1) * limit}&limit=$limit',
                token: token!,
              )
            : await apiController.getMethodWithoutBodyAndHeader(
                endPoint:
                    'upcoming_events?offset=${(page - 1) * limit}&limit=$limit',
              );

        print(
          "UpComingEventBlocUpComingEventBlocUpComingEventBlocUpComingEventBlocUpComingEventBloc$response",
        );

        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            upComingEventList.addAll(responseBody['data']);
            hasMore = responseBody['data'].length == limit;
            isLoadingMore = false;

            emit(
              UpComingEventListSuccess(
                upComingEventList: List.from(upComingEventList),
                hasMore: hasMore,
              ),
            );
          } else {
            emit(UpComingEventListFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(UpComingEventListFail(errorMessage: error));
      } catch (e) {
        emit(
          UpComingEventListFail(
            errorMessage: ConfigMessage().unexpectedErrorMsg,
          ),
        );
      }
    });
  }
}
