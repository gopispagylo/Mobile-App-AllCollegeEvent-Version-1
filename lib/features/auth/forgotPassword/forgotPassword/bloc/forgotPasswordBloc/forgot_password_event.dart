part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordEvent {}

class ClickedSendMail extends ForgotPasswordEvent{
  final String email;

  ClickedSendMail({required this.email});
}