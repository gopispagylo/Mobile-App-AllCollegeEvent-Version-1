part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState{}

class SignUpSuccess extends SignUpState{}

class SignUpFail extends SignUpState{
  final String errorMessage;

  SignUpFail({required this.errorMessage});
}