part of 'google_sign_in_bloc.dart';

@immutable
sealed class GoogleSignInState {}

final class GoogleSignInInitial extends GoogleSignInState {}

class GoogleSignInLoading extends GoogleSignInState{}

class GoogleSignInSuccess extends GoogleSignInState{}

class GoogleSignInFail extends GoogleSignInState{
  final String errorMessage;

  GoogleSignInFail({required this.errorMessage});
}