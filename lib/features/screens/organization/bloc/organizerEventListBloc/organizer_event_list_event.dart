part of 'organizer_event_list_bloc.dart';

@immutable
sealed class OrganizerEventListEvent {}

class FetchOrganizerEvent extends OrganizerEventListEvent {
  final String slug;
  final bool isLogin;

  FetchOrganizerEvent({required this.slug, required this.isLogin});
}
