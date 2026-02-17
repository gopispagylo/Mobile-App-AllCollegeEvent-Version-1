import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'virtual_event_event.dart';
part 'virtual_event_state.dart';

class VirtualEventBloc extends Bloc<VirtualEventEvent, VirtualEventState> {
  final ApiController apiController;
  final List<dynamic> virtualEventList = [];

  int page = 1;
  final int limit = 2;

  bool hasMore = true;
  bool isLoadingMore = false;

  VirtualEventBloc({required this.apiController})
    : super(VirtualEventInitial()) {
    on<FetchVirtualEventList>((event, emit) async {
      if (!event.loadMore) {
        page = 1;
        hasMore = true;
        virtualEventList.clear();
        emit(VirtualEventListLoading());
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
                    'virtual_events?offset=${(page - 1) * limit}&limit=$limit',
                token: token!,
              )
            : await apiController.getMethodWithoutBodyAndHeader(
                endPoint:
                    'virtual_events?offset=${(page - 1) * limit}&limit=$limit',
              );

        print(
          "VirtualEventBlocVirtualEventBlocVirtualEventBlocVirtualEventBlocVirtualEventBloc$response",
        );

        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            virtualEventList.addAll(responseBody['data']);
            hasMore = responseBody['data'].length == limit;
            isLoadingMore = false;

            emit(
              VirtualEventListSuccess(
                virtualEventList: List.from(virtualEventList),
                hasMore: hasMore,
              ),
            );
          } else {
            emit(VirtualEventListFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(VirtualEventListFail(errorMessage: error));
      } catch (e) {
        emit(
          VirtualEventListFail(
            errorMessage: ConfigMessage().unexpectedErrorMsg,
          ),
        );
      }
    });
  }
}
