part of 'organizer_detail_bloc.dart';

@immutable
sealed class OrganizerDetailEvent {}

class ClickOrgDetail extends OrganizerDetailEvent{
  final String slug;

  ClickOrgDetail({required this.slug});
}