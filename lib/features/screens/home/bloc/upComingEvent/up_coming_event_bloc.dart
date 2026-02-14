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
  final int limit = 5;

  bool hasMore = true;
  bool isLoadingMore = false;

  UpComingEventBloc({required this.apiController})
    : super(UpComingEventInitial()) {
    on<FetchUpComingEvent>((event, emit) async {
      if (!event.loadMore) {
        page = 1;
        hasMore = true;
        upComingEventList.clear();
        emit(LoadingUpComingEventList());
      } else {
        if (isLoadingMore || !hasMore) return;
        isLoadingMore = true;
        page++;
      }
      try {
        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ----- access token data base -------
        final token = await DBHelper().getToken();

        final response = event.isLogin
            ? await apiController.getMethodWithoutBody(
                endPoint:
                    'organizations/${event.slug}/events_protec?page=${(page - 1) * limit}&limit=$limit',
                token: token!,
              )
            : await apiController.getMethodWithoutBodyAndHeader(
                endPoint:
                    'organizations/${event.slug}/events?page=${(page - 1) * limit}&limit=$limit',
              );

        print(
          "PastEventBlocPastEventBlocPastEventBlocPastEventBlocPastEventBloc$response",
        );

        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            upComingEventList.addAll(responseBody['data']);
            hasMore = responseBody['data'].length == limit;
            isLoadingMore = false;

            emit(
              SuccessUpComingEventList(
                upComingEventList: List.from(upComingEventList),
                hasMore: hasMore,
              ),
            );
          } else {
            emit(FailUpComingEventList(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(FailUpComingEventList(errorMessage: error));
      } catch (e) {
        emit(
          FailUpComingEventList(
            errorMessage: ConfigMessage().unexpectedErrorMsg,
          ),
        );
      }
    });
  }
}
