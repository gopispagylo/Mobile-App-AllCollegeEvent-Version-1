part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState{}

class ForgotPasswordSuccess extends ForgotPasswordState{}

class ForgotPasswordFail extends ForgotPasswordState{
  final String errorMessage;

  ForgotPasswordFail({required this.errorMessage});
}