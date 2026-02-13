part of 'create_follow_bloc.dart';

@immutable
sealed class CreateFollowEvent {}

class ClickCreateFollow extends CreateFollowEvent {
  final String orgId;
  final bool isFollow;

  ClickCreateFollow({required this.orgId, required this.isFollow});
}
