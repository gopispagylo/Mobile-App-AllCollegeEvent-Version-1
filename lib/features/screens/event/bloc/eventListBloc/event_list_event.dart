part of 'event_list_bloc.dart';

@immutable
sealed class EventListEvent {}

class FetchEventList extends EventListEvent {
  final List<String>? eventTypes;
  final List<dynamic>? modes;
  final List<String>? eligibleDeptIdentities;
  final String? certIdentity;
  final String? eventTypeIdentity;
  final List<String>? perkIdentities;
  final List<String>? accommodationIdentities;
  final String? country;
  final String? state;
  final String? city;
  final DateTime? startDate;
  // final DateTime? endDate;
  // final int? minPrice;
  // final int? maxPrice;
  // final int? page;
  // final int? limit;
  // final String? sortBy;

  FetchEventList({
    required this.eventTypes,
    required this.modes,
    required this.eligibleDeptIdentities,
    required this.certIdentity,
    required this.eventTypeIdentity,
    required this.perkIdentities,
    required this.accommodationIdentities,
    required this.country,
    required this.state,
    required this.city,
    required this.startDate,
    // required this.endDate,
    // required this.minPrice,
    // required this.maxPrice,
    // required this.page,
    // required this.limit,
    // required this.sortBy,
  });
}

class SearchEventList extends EventListEvent{
  final String? searchText;

  SearchEventList({required this.searchText});
}
