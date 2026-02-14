import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'create_follow_event.dart';
part 'create_follow_state.dart';

class CreateFollowBloc extends Bloc<CreateFollowEvent, CreateFollowState> {
  final ApiController apiController;
  final Map<String, dynamic> followStatus = {};

  CreateFollowBloc({required this.apiController})
    : super(CreateFollowInitial()) {
    on<ClickCreateFollow>((event, emit) async {
      try {
        final orgId = event.orgId;

        // initialize first data
        final currentFollow = followStatus[orgId] ?? event.isFollow;

        // ---- optimistic update ----
        final newFollow = !currentFollow;

        followStatus[orgId] = newFollow;

        emit(SuccessCreateFollow(orgId: orgId, isFollow: newFollow));

        // --------- set a base url --------
        await apiController.setBaseUrl();

        // ------- token -------
        final token = await DBHelper().getToken();

        // body
        final params = {"orgIdentity": event.orgId};

        final response = await apiController.postMethodWithHeader(
          endPoint: 'organizations/follow-org',
          token: token!,
          data: params,
        );
        print(
          "CreateFollowBlocCreateFollowBlocCreateFollowBlocCreateFollowBloc$response",
        );
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
          } else {
            emit(SuccessCreateFollow(orgId: orgId, isFollow: newFollow));
          }
        } else {
          emit(
            FailCreateFollow(
              errorMessage: ConfigMessage().serverError,
              orgId: event.orgId,
              previousValue: event.isFollow,
            ),
          );
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(
          FailCreateFollow(
            errorMessage: error,
            orgId: event.orgId,
            previousValue: event.isFollow,
          ),
        );
      } catch (e) {
        emit(
          FailCreateFollow(
            errorMessage: ConfigMessage().unexpectedErrorMsg,
            orgId: event.orgId,
            previousValue: event.isFollow,
          ),
        );
      }
    });
  }
}
