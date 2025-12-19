part of 'reset_password_bloc.dart';

@immutable
sealed class ResetPasswordEvent {}

class ClickedResetPassword extends ResetPasswordEvent{
  final String email;
  final String password;

  ClickedResetPassword({required this.email, required this.password});
}

