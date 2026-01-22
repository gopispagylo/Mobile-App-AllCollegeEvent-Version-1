part of 'city_bloc.dart';

@immutable
sealed class CityEvent {}

class FetchCity extends CityEvent{
  final String stateCode;

  FetchCity({required this.stateCode});
}
