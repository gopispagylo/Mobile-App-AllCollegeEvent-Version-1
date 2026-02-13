part of 'create_follow_bloc.dart';

@immutable
sealed class CreateFollowState {}

final class CreateFollowInitial extends CreateFollowState {}

class SuccessCreateFollow extends CreateFollowState {
  final String orgId;
  final bool isFollow;

  SuccessCreateFollow({required this.orgId, required this.isFollow});
}

class FailCreateFollow extends CreateFollowState {
  final String errorMessage;
  final String orgId;
  final bool previousValue;

  FailCreateFollow({
    required this.errorMessage,
    required this.orgId,
    required this.previousValue,
  });
}
