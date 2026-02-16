part of 'country_based_event_bloc.dart';

@immutable
sealed class CountryBasedEventEvent {}

class FetchCountryBaseEvent extends CountryBasedEventEvent {
  final bool isLogin;
  final bool loadMore;
  final String countryCode;
  final String name;

  FetchCountryBaseEvent({
    required this.isLogin,
    this.loadMore = false,
    required this.countryCode,
    required this.name,
  });
}
