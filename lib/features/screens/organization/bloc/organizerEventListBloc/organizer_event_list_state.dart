part of 'organizer_event_list_bloc.dart';

@immutable
sealed class OrganizerEventListState {}

final class OrganizerEventListInitial extends OrganizerEventListState {}

class OrganizerEventLoading extends OrganizerEventListState{}

class OrganizerEventSuccess extends OrganizerEventListState{
  final List<dynamic> organizerEventList;

  OrganizerEventSuccess({required this.organizerEventList});
}

class OrganizerEventFail extends OrganizerEventListState{
  final String errorMessage;

  OrganizerEventFail({required this.errorMessage});
}