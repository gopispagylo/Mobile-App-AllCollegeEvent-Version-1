part of 'popular_city_country_bloc.dart';

@immutable
sealed class PopularCityCountryEvent {}

class FetchPopularCityCountry extends PopularCityCountryEvent {}
