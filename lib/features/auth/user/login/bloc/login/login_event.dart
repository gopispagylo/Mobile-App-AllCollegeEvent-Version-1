part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class ClickedLogin extends LoginEvent{
  final String email;
  final String password;
  final String type;

  ClickedLogin({required this.email, required this.password, required this.type});
}
