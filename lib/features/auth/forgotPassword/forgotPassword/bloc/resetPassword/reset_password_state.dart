part of 'reset_password_bloc.dart';

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState{}

class ResetPasswordSuccess extends ResetPasswordState{}

class ResetPasswordFail extends ResetPasswordState{
  final String errorMessage;

  ResetPasswordFail({required this.errorMessage});
}