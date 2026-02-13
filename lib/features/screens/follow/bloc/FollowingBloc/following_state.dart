part of 'following_bloc.dart';

@immutable
sealed class FollowingState {}

final class FollowingInitial extends FollowingState {}

class LoadingFollowing extends FollowingState {}

class SuccessFollowing extends FollowingState {
  final List<dynamic> followingList;

  SuccessFollowing({required this.followingList});
}

class FailFollowing extends FollowingState {
  final String errorMessage;

  FailFollowing({required this.errorMessage});
}
