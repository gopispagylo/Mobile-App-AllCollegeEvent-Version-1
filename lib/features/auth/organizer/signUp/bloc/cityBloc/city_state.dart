part of 'city_bloc.dart';

@immutable
sealed class CityState {}

final class CityInitial extends CityState {}

class CityLoading extends CityState{}

class CitySuccess extends CityState{
  final List<dynamic> cityList;

  CitySuccess({required this.cityList});
}

class CityFail extends CityState{
  final String errorMessage;

  CityFail({required this.errorMessage});
}