import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'featured_event_event.dart';
part 'featured_event_state.dart';

class FeaturedEventBloc extends Bloc<FeaturedEventEvent, FeaturedEventState> {
  final ApiController apiController;
  final List<dynamic> featuredEventList = [];

  int page = 1;
  final int limit = 2;

  bool hasMore = true;
  bool isLoadingMore = false;
  FeaturedEventBloc({required this.apiController})
    : super(FeaturedEventInitial()) {
    on<FetchFeaturedEventList>((event, emit) async {
      if (!event.loadMore) {
        page = 1;
        hasMore = true;
        featuredEventList.clear();
        emit(FeaturedEventListLoading());
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
                    'featured_events?offset=${(page - 1) * limit}&limit=$limit',
                token: token!,
              )
            : await apiController.getMethodWithoutBodyAndHeader(
                endPoint:
                    'featured_events?offset=${(page - 1) * limit}&limit=$limit',
              );

        print(
          "FeaturedEventBlocFeaturedEventBlocFeaturedEventBlocFeaturedEventBlocFeaturedEventBloc$response",
        );

        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            featuredEventList.addAll(responseBody['data']);
            hasMore = responseBody['data'].length == limit;
            isLoadingMore = false;

            emit(
              FeaturedEventListSuccess(
                featuredEventList: List.from(featuredEventList),
                hasMore: hasMore,
              ),
            );
          } else {
            emit(FeaturedEventListFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(FeaturedEventListFail(errorMessage: error));
      } catch (e) {
        emit(
          FeaturedEventListFail(
            errorMessage: ConfigMessage().unexpectedErrorMsg,
          ),
        );
      }
    });
  }
}
