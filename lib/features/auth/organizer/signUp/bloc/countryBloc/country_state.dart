part of 'country_bloc.dart';

@immutable
sealed class CountryState {}

final class CountryInitial extends CountryState {}

class CountryLoading extends CountryState{}

class CountrySuccess extends CountryState{
  final List<dynamic> countryList;

  CountrySuccess({required this.countryList});
}

class CountryFail extends CountryState{
  final String errorMessage;

  CountryFail({required this.errorMessage});
}