part of 'accommodation_bloc.dart';

@immutable
sealed class AccommodationState {}

final class AccommodationInitial extends AccommodationState {}

class AccommodationLoading extends AccommodationState{}

class AccommodationSuccess extends AccommodationState{
  final List<dynamic> accommodationList;

  AccommodationSuccess({required this.accommodationList});
}

class AccommodationFail extends AccommodationState{
  final String errorMessage;

  AccommodationFail({required this.errorMessage});
}