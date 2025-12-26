part of 'user_update_bloc.dart';

@immutable
sealed class UserUpdateEvent {}

class ClickUserUpdate extends UserUpdateEvent{
  final String state;
  final String city;
  final String country;
  final String phone;
  final String name;

  ClickUserUpdate({required this.state, required this.city, required this.country, required this.phone, required this.name});
}
