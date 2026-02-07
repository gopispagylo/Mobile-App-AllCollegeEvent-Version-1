part of 'organizer_detail_bloc.dart';

@immutable
sealed class OrganizerDetailEvent {}

class ClickOrgDetail extends OrganizerDetailEvent {
  final String slug;
  final bool isLogin;

  ClickOrgDetail({required this.slug, required this.isLogin});
}
