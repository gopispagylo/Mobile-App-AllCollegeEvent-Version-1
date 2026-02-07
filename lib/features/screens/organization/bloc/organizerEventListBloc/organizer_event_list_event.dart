part of 'organizer_event_list_bloc.dart';

@immutable
sealed class OrganizerEventListEvent {}

class FetchOrganizerEvent extends OrganizerEventListEvent {
  final String eventId;
  final bool isLogin;

  FetchOrganizerEvent({required this.eventId, required this.isLogin});
}
