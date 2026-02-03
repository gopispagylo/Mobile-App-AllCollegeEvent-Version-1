import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'event_list_event.dart';
part 'event_list_state.dart';

class EventListBloc extends Bloc<EventListEvent, EventListState> {
  final ApiController apiController;
  final List<dynamic> eventList = [];
  EventListBloc({required this.apiController}) : super(EventListInitial()) {
    on<FetchEventList>((event, emit) async {
      emit(EventListLoading());

      try {
        // --------- set a base url -------
        await apiController.setBaseUrl();

        final Map<String, dynamic> params = {};

        if (event.eventTypes != null && event.eventTypes!.isNotEmpty) {
          params["eventTypes"] = event.eventTypes;
        }

        if (event.eventTypes == 'trending') {
          params["trendingThreshold"] = 10;
        }

        if (event.modes != null && event.modes!.isNotEmpty) {
          params["modes"] = event.modes;
        }
        //
        // if (event.searchText != null && event.searchText!.trim().isNotEmpty) {
        //   params["searchText"] = event.searchText!.trim();
        // }

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

        // if (event.startDate != null || event.endDate != null) {
        //   params["dateRange"] = {
        //     if (event.startDate != null)
        //       "startDate": event.startDate!.toIso8601String().split('T').first,
        //     if (event.endDate != null)
        //       "endDate": event.endDate!.toIso8601String().split('T').first,
        //   };
        // }
        //
        // if (event.minPrice != null || event.maxPrice != null) {
        //   params["priceRange"] = {
        //     if (event.minPrice != null) "min": event.minPrice,
        //     if (event.maxPrice != null) "max": event.maxPrice,
        //   };
        // }
        //
        // if (event.page != null) {
        //   params["page"] = event.page;
        // }
        //
        // if (event.limit != null) {
        //   params["limit"] = event.limit;
        // }
        //
        // if (event.sortBy != null && event.sortBy!.isNotEmpty) {
        //   params["sortBy"] = event.sortBy;
        // }

        final token = await DBHelper().getToken();

        final response = await apiController.postMethodWithHeader(
          endPoint: 'filter_protec',
          data: params,
          token: token!,
        );
        print('EventListBlocEventListBlocEventListBlocEventListBloc$response');
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            print(
              'EventListBlocEventListBlocEventListBlocEventListBloc$response',
            );
            eventList.clear();
            eventList.addAll(responseBody['data']);
            if (responseBody['data'].isNotEmpty) {
              emit(EventSuccess(eventList: List.from(eventList)));
            } else {
              emit(EventFail(errorMessage: "No data found"));
            }
          } else {
            emit(EventFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        print('EventListBlocEventListBlocEventListBlocEventListBloc$e');
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(EventFail(errorMessage: error));
      } catch (e) {
        print('EventListBlocEventListBlocEventListBlocEventListBloc$e');
        emit(EventFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });

    on<SearchEventList>((event, emit) async {
      emit(EventListLoading());

      try {
        // --------- set a base url -------
        await apiController.setBaseUrl();

        final Map<String, dynamic> params = {};
        params['searchText'] = event.searchText;

        final token = await DBHelper().getToken();

        final response = await apiController.postMethodWithHeader(
          endPoint: 'filter_protec',
          data: params,
          token: token!,
        );
        print(
          'SearchEventListSearchEventListSearchEventListSearchEventListSearchEventList$response',
        );
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            print(
              'EventListBlocEventListBlocEventListBlocEventListBloc$response',
            );
            eventList.clear();
            eventList.addAll(responseBody['data']);
            if (responseBody['data'].isNotEmpty) {
              emit(EventSuccess(eventList: List.from(eventList)));
            } else {
              emit(EventFail(errorMessage: "No data found"));
            }
          } else {
            emit(EventFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        print('EventListBlocEventListBlocEventListBlocEventListBloc$e');
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(EventFail(errorMessage: error));
      } catch (e) {
        print('EventListBlocEventListBlocEventListBlocEventListBloc$e');
        emit(EventFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
