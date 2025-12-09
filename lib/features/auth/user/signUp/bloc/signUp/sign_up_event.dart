part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class ClickedSignUp extends SignUpEvent{
  final String name;
  final String email;
  final String password;
  final String type;

  ClickedSignUp({required this.name, required this.email, required this.password, required this.type});
}