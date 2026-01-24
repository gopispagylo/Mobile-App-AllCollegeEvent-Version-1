part of 'organizer_event_list_bloc.dart';

@immutable
sealed class OrganizerEventListEvent {}

class FetchOrganizerEvent extends OrganizerEventListEvent{
  final String eventId;

  FetchOrganizerEvent({required this.eventId});
}