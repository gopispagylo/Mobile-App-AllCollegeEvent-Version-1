part of 'user_update_bloc.dart';

@immutable
sealed class UserUpdateState {}

final class UserUpdateInitial extends UserUpdateState {}

class UserUpdateLoading extends UserUpdateState{}

class UserUpdateSuccess extends UserUpdateState{}

class UserUpdateFail extends UserUpdateState{
  final String errorMessage;

  UserUpdateFail({required this.errorMessage});
}

// ------------ social link state -----------------
class SocialLinkOrganizerLoading extends UserUpdateState{}

class SocialLinkOrganizerSuccess extends UserUpdateState{}

class SocialLinkOrganizerFail extends UserUpdateState{
  final String errorMessage;

  SocialLinkOrganizerFail({required this.errorMessage});
}