part of 'following_bloc.dart';

@immutable
sealed class FollowingEvent {}

class FetchFollowing extends FollowingEvent {
  final String followingOrFollowers;

  FetchFollowing({required this.followingOrFollowers});
}
