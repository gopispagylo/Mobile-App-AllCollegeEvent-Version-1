part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState{}

class LoginSuccess extends LoginState{}

class LoginFail extends LoginState{
  final String errorMessage;

  LoginFail({required this.errorMessage});
}
