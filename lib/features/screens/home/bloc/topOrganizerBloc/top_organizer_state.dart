part of 'top_organizer_bloc.dart';

@immutable
sealed class TopOrganizerState {}

final class TopOrganizerInitial extends TopOrganizerState {}

class TopOrganizerLoading extends TopOrganizerState{}

class TopOrganizerSuccess extends TopOrganizerState{
  final List<dynamic> topOrganizer;

  TopOrganizerSuccess({required this.topOrganizer});
}

class TopOrganizerFail extends TopOrganizerState{
  final String errorMessage;

  TopOrganizerFail({required this.errorMessage});
}