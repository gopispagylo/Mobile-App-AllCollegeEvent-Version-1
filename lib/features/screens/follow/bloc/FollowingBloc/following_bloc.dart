import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'following_event.dart';
part 'following_state.dart';

class FollowingBloc extends Bloc<FollowingEvent, FollowingState> {
  final ApiController apiController;
  final List<dynamic> followingList = [];
  FollowingBloc({required this.apiController}) : super(FollowingInitial()) {
    on<FetchFollowing>((event, emit) async {
      emit(LoadingFollowing());
      try {
        // --------- set a base url --------
        await apiController.setBaseUrl();

        // ------- token -------
        final token = await DBHelper().getToken();

        final response = await apiController.getMethodWithoutBody(
          endPoint: 'organizations/followers-following',
          token: token!,
        );

        print(
          "FollowingBlocFollowingBlocFollowingBlocFollowingBlocFollowingBlocFollowingBlocFollowingBloc$response",
        );

        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            final follow = event.followingOrFollowers == "following"
                ? responseBody['data']['following']
                : responseBody['data']['followers'];
            followingList.clear();
            followingList.addAll(follow);
            if (follow.isNotEmpty) {
              emit(SuccessFollowing(followingList: List.from(followingList)));
            } else {
              emit(FailFollowing(errorMessage: "No data found"));
            }
          } else {
            emit(FailFollowing(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(FailFollowing(errorMessage: error));
      } catch (e) {
        emit(FailFollowing(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
