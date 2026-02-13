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

  // local cache
  final Map<String, bool> favStatus = {};
  final Map<String, int> likeCount = {};

  EventLikeBloc({required this.apiController}) : super(EventLikeInitial()) {
    on<ClickEventLike>(_onClickEventLike);
  }

  Future<void> _onClickEventLike(
    ClickEventLike event,
    Emitter<EventLikeState> emit,
  ) async {
    final eventId = event.eventId;

    // ---- initialize from UI if not exists ----
    final currentFav = favStatus[eventId] ?? event.initialFav;
    final currentCount = likeCount[eventId] ?? event.initialCount;

    // ---- optimistic update ----
    final newFav = !currentFav;
    final newCount = newFav ? currentCount + 1 : currentCount - 1;

    favStatus[eventId] = newFav;
    likeCount[eventId] = newCount;

    emit(
      EventLikeSuccess(
        id: eventId,
        checkFav: newFav,
        count: newCount.toString(),
      ),
    );

    try {
      await apiController.setBaseUrl();

      final token = await DBHelper().getToken();
      final userId = await DBHelper().getUserId();

      final params = {"eventIdentity": eventId, "userIdentity": userId};

      final response = await apiController.postMethodWithHeader(
        endPoint: "events/like",
        token: token!,
        data: params,
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        final apiCount =
            int.tryParse(response.data['likeCount'].toString()) ?? newCount;

        likeCount[eventId] = apiCount;

        emit(
          EventLikeSuccess(
            id: eventId,
            checkFav: newFav,
            count: apiCount.toString(),
          ),
        );
      } else {
        _rollback(
          eventId,
          currentFav,
          currentCount,
          emit,
          response.data['message'],
        );
      }
    } on DioException catch (e) {
      final error = HandleErrorConfig().handleDioError(e);
      _rollback(eventId, currentFav, currentCount, emit, error);
    } catch (_) {
      _rollback(
        eventId,
        currentFav,
        currentCount,
        emit,
        ConfigMessage().unexpectedErrorMsg,
      );
    }
  }

  void _rollback(
    String eventId,
    bool oldFav,
    int oldCount,
    Emitter<EventLikeState> emit,
    String error,
  ) {
    favStatus[eventId] = oldFav;
    likeCount[eventId] = oldCount;

    emit(
      EventLikeSuccess(
        id: eventId,
        checkFav: oldFav,
        count: oldCount.toString(),
      ),
    );

    emit(EventLikeFail(id: eventId, errorMessage: error));
  }
}
