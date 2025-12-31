part of 'country_bloc.dart';

@immutable
sealed class CountryEvent {}

class FetchCountry extends CountryEvent{}