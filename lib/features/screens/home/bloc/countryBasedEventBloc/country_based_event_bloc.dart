import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'country_based_event_event.dart';
part 'country_based_event_state.dart';

class CountryBasedEventBloc
    extends Bloc<CountryBasedEventEvent, CountryBasedEventState> {
  final ApiController apiController;
  final List<dynamic> countryBasedEventList = [];

  int page = 1;
  final int limit = 10;

  bool hasMore = true;
  bool isLoadingMore = false;

  CountryBasedEventBloc({required this.apiController})
    : super(CountryBasedEventInitial()) {
    on<FetchCountryBaseEvent>((event, emit) async {
      if (!event.loadMore) {
        page = 1;
        hasMore = true;
        countryBasedEventList.clear();
        emit(CountryBasedEventLoading());
      } else {
        if (isLoadingMore || !hasMore) {
          isLoadingMore = true;
          page++;
        }
      }
      try {
        // --------- set a base url ---------
        await apiController.setBaseUrl();

        // ------- token -------
        final token = await DBHelper().getToken();

        final response = event.isLogin
            ? await apiController.getMethodWithoutBody(
                endPoint:
                    'analytics/location?${event.name == 'country' ? 'country' : "city"}=${event.countryCode}&${(page - 1) * limit}&limit=$limit',
                token: token!,
              )
            : await apiController.getMethodWithoutBodyAndHeader(
                endPoint:
                    'analytics/location?${event.name == 'country' ? 'country' : "city"}=${event.countryCode}&${(page - 1) * limit}&limit=$limit',
              );

        print(
          "CountryBasedEventBlocCountryBasedEventBlocCountryBasedEventBlocCountryBasedEventBloc$response",
        );

        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            countryBasedEventList.addAll(responseBody['data']);
            hasMore = responseBody['data'].length == limit;
            isLoadingMore = false;

            emit(
              CountryBasedEventSuccess(
                countryBasedEventList: List.from(countryBasedEventList),
                hasMore: hasMore,
              ),
            );
          } else {
            emit(CountryBasedEventFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(CountryBasedEventFail(errorMessage: error));
      } catch (e) {
        emit(
          CountryBasedEventFail(
            errorMessage: ConfigMessage().unexpectedErrorMsg,
          ),
        );
      }
    });
  }
}
