part of 'user_update_bloc.dart';

@immutable
sealed class UserUpdateEvent {}

class ClickUserUpdate extends UserUpdateEvent{
  final String whichUser;
  final String userState;
  final String city;
  final String country;
  final String phone;
  final String name;
  final PlatformFile? profileImage;

  ClickUserUpdate({required this.userState, required this.city, required this.country, required this.phone, required this.name, required this.whichUser, required this.profileImage});
}
