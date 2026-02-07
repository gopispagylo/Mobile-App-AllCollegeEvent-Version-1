import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'search_event_list_event.dart';
part 'search_event_list_state.dart';

class SearchEventListBloc
    extends Bloc<SearchEventListEvent, SearchEventListState> {
  final ApiController apiController;
  final List<dynamic> searchEventList = [];
  SearchEventListBloc({required this.apiController})
    : super(SearchEventListInitial()) {
    on<FetchSearchEventList>((event, emit) async {
      // show loader only for first page
      if (!event.isLoadMore) {
        emit(SearchEventListLoading());
      }
      try {
        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ------- token -------
        final token = await DBHelper().getToken();
        final Map<String, dynamic> params = {
          "page": event.page,
          "limit": event.limit,
        };

        print("limitlimitlimitlimitlimitlimitlimit${event.limit}");

        if (event.eventTypes != null && event.eventTypes!.isNotEmpty) {
          params["eventTypes"] = event.eventTypes;
        }

        if (event.eventTypes == 'trending') {
          params["trendingThreshold"] = 10;
        }

        if (event.modes != null && event.modes!.isNotEmpty) {
          params["modes"] = event.modes;
        }

        if (event.eligibleDeptIdentities != null &&
            event.eligibleDeptIdentities!.isNotEmpty) {
          params["eligibleDeptIdentities"] = event.eligibleDeptIdentities;
        }

        if (event.certIdentity != null && event.certIdentity!.isNotEmpty) {
          params["certIdentity"] = event.certIdentity;
        }

        if (event.eventTypeIdentity != null &&
            event.eventTypeIdentity!.isNotEmpty) {
          params["eventTypeIdentity"] = event.eventTypeIdentity;
        }

        if (event.perkIdentities != null && event.perkIdentities!.isNotEmpty) {
          params["perkIdentities"] = event.perkIdentities;
        }

        if (event.accommodationIdentities != null &&
            event.accommodationIdentities!.isNotEmpty) {
          params["accommodationIdentities"] = event.accommodationIdentities;
        }

        if (event.country != null && event.country!.isNotEmpty) {
          params["country"] = event.country;
        }

        if (event.state != null && event.state!.isNotEmpty) {
          params["state"] = event.state;
        }

        if (event.city != null && event.city!.isNotEmpty) {
          params["city"] = event.city;
        }

        if (event.startDate != null || event.endDate != null) {
          params["dateRange"] = {
            if (event.startDate != null)
              "startDate": event.startDate!.toIso8601String().split('T').first,
            if (event.endDate != null)
              "endDate": event.endDate!.toIso8601String().split('T').first,
          };
        }

        if (event.minPrice != null || event.maxPrice != null) {
          params["priceRange"] = {
            if (event.minPrice != null) "min": event.minPrice,
            if (event.maxPrice != null) "max": event.maxPrice,
          };
        }

        if (event.searchText != null && event.searchText!.trim().isNotEmpty) {
          params["searchText"] = event.searchText!.trim();
        }

        //
        // if (event.sortBy != null && event.sortBy!.isNotEmpty) {
        //   params["sortBy"] = event.sortBy;
        // }

        print("paramsparamsparamsparamsparams${params.keys}${params.values}");

        final response = event.isLogin
            ? await apiController.postMethodWithHeader(
                data: params,
                endPoint: 'filter_protec',
                token: token!,
              )
            : await apiController.postMethodWithOutHeader(
                data: params,
                endPoint: 'filter',
              );

        print(
          "SearchEventListBlocSearchEventListBlocSearchEventListBlocSearchEventListBloc$response",
        );
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            // reset only on first page
            if (!event.isLoadMore) {
              searchEventList.clear();
            }
            searchEventList.addAll(responseBody['data']);
            if (responseBody['data'].isNotEmpty) {
              emit(
                SearchEventListSuccess(
                  hasMore: responseBody['data'].length == event.limit,
                  searchEventList: List.from(searchEventList),
                ),
              );
            } else {
              emit(SearchEventListFail(errorMessage: "No data found"));
            }
          } else {
            emit(SearchEventListFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        print("kfkfkfkfkfkfkfk$e");
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(SearchEventListFail(errorMessage: error));
      } catch (e) {
        print("kfkfkfkfkfkfkfk$e");
        emit(
          SearchEventListFail(errorMessage: ConfigMessage().unexpectedErrorMsg),
        );
      }
    });
  }
}
