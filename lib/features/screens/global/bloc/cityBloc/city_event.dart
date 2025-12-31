part of 'city_bloc.dart';

@immutable
sealed class CityEvent {}

class FetchCity extends CityEvent{
  final String stateCode;
  final String countryCode;

  FetchCity({required this.stateCode, required this.countryCode});
}
