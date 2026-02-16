part of 'country_based_event_bloc.dart';

@immutable
sealed class CountryBasedEventState {}

final class CountryBasedEventInitial extends CountryBasedEventState {}

class CountryBasedEventLoading extends CountryBasedEventState {}

class CountryBasedEventSuccess extends CountryBasedEventState {
  final List<dynamic> countryBasedEventList;
  final bool hasMore;

  CountryBasedEventSuccess({
    required this.countryBasedEventList,
    required this.hasMore,
  });
}

class CountryBasedEventFail extends CountryBasedEventState {
  final String errorMessage;

  CountryBasedEventFail({required this.errorMessage});
}
