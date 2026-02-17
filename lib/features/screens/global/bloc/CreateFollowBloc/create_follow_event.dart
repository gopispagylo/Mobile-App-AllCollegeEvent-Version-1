part of 'create_follow_bloc.dart';

@immutable
sealed class CreateFollowEvent {}

class ClickCreateFollow extends CreateFollowEvent {
  final String orgId;
  final bool isFollow;
  final bool unFollow;

  ClickCreateFollow({
    required this.orgId,
    required this.isFollow,
    required this.unFollow,
  });
}
