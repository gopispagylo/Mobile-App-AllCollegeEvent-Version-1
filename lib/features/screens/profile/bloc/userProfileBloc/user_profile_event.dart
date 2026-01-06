part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}

class ClickedUserProfile extends UserProfileEvent{
  final String whichUser;

  ClickedUserProfile({required this.whichUser});
}

