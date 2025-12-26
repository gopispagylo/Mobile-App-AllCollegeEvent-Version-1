part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState{}

class UserProfileSuccess extends UserProfileState{
  final List<dynamic> userProfileList;

  UserProfileSuccess({required this.userProfileList});
}

class UserProfileFail extends UserProfileState{
  final String errorMessage;

  UserProfileFail({required this.errorMessage});
}