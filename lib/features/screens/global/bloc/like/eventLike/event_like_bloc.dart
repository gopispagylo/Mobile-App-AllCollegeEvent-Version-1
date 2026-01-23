import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'event_like_event.dart';

part 'event_like_state.dart';

class EventLikeBloc extends Bloc<EventLikeEvent, EventLikeState> {
  final ApiController apiController;
  final Map<String, bool> favStatus = {};
  final Map<String, int> likeCount = {};

  EventLikeBloc({required this.apiController}) : super(EventLikeInitial()) {
    on<ClickEventLike>((event, emit) async {
      try {
        await apiController.setBaseUrl();

        // ------- token --------
        final token = await DBHelper().getToken();

        // ------- user or org id --------
        final userId = await DBHelper().getUserId();

        // ------ id for event id ------
        final eventId = event.eventId.toString();

        // -------- immediately change the act toggle ----
        final newFav = !(favStatus[eventId] ?? false);
        favStatus[eventId] = newFav;
        final previousCount = likeCount[eventId] ?? 0;
        emit(
          EventLikeSuccess(
            checkFav: newFav,
            id: eventId,
            count: previousCount.toString(),
          ),
        );

        final params = {"eventIdentity": event.eventId, "userIdentity": userId};

        final response = await apiController.postMethodWithHeader(
          endPoint: "events/like",
          token: token!,
          data: params,
        );

        print("responseresponseresponseresponseresponseresponse$response");
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            final likeCountApi =
                int.tryParse(responseBody['likeCount'].toString()) ?? 0;
            likeCount[eventId] = likeCountApi;
            emit(
              EventLikeSuccess(
                checkFav: newFav,
                id: eventId,
                count: likeCountApi.toString(),
              ),
            );
          } else {
            emit(
              EventLikeFail(
                errorMessage: responseBody['message'],
                id: event.eventId,
              ),
            );
          }
        }
      } on DioException catch (e) {
        final error = HandleErrorConfig().handleDioError(e);
        emit(EventLikeFail(errorMessage: error, id: event.eventId));
      } catch (e) {
        emit(
          EventLikeFail(
            errorMessage: ConfigMessage().unexpectedErrorMsg,
            id: event.eventId,
          ),
        );
      }
    });
  }
}
