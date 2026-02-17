import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'past_event_event.dart';
part 'past_event_state.dart';

class PastEventBloc extends Bloc<PastEventEvent, PastEventState> {
  final ApiController apiController;
  final List<dynamic> pastEventList = [];

  int page = 1;
  final int limit = 4;

  bool hasMore = true;
  bool isLoadingMore = false;

  PastEventBloc({required this.apiController}) : super(PastEventInitial()) {
    on<FetchPastEventList>((event, emit) async {
      if (!event.loadMore) {
        page = 1;
        hasMore = true;
        pastEventList.clear();
        emit(LoadingPastEventList());
      } else {
        if (isLoadingMore || !hasMore) return;
        isLoadingMore = true;
        page++;
      }

      try {
        // --------- set a base url -------
        await apiController.setBaseUrl();

        // response
        final response = await apiController.getMethodWithoutBodyAndHeader(
          endPoint:
              'organizations/${event.slug}/past-events?offset=${(page - 1) * limit}&limit=$limit',
        );

        print(
          "PastEventBlocPastEventBlocPastEventBlocPastEventBlocPastEventBloc$response",
        );

        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            // when a data is empty show error
            if (!event.loadMore && responseBody['data'].isEmpty) {
              emit(FailPastEventList(errorMessage: "Data not found"));
              return;
            }
            pastEventList.addAll(responseBody['data']);
            hasMore = responseBody['data'].length == limit;
            isLoadingMore = false;

            emit(
              SuccessPastEventList(
                pastEventList: List.from(pastEventList),
                hasMore: hasMore,
              ),
            );
          } else {
            emit(FailPastEventList(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(FailPastEventList(errorMessage: error));
      } catch (e) {
        emit(
          FailPastEventList(errorMessage: ConfigMessage().unexpectedErrorMsg),
        );
      }
    });
  }
}
