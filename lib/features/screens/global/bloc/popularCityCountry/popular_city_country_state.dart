part of 'popular_city_country_bloc.dart';

@immutable
sealed class PopularCityCountryState {}

final class PopularCityCountryInitial extends PopularCityCountryState {}

class LoadingPopularCityCountry extends PopularCityCountryState {}

class SuccessPopularCityCountry extends PopularCityCountryState {
  final Map<String, dynamic> cityCountryList;

  SuccessPopularCityCountry({required this.cityCountryList});
}

class FailPopularCityCountry extends PopularCityCountryState {
  final String errorMessage;

  FailPopularCityCountry({required this.errorMessage});
}
