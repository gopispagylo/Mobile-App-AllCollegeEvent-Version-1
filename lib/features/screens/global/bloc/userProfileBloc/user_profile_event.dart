part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}

class ClickedUserProfile extends UserProfileEvent {
  final String whichUser;
  final String id;

  ClickedUserProfile({required this.whichUser, required this.id});
}
