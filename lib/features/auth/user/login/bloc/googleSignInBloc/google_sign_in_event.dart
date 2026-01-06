part of 'google_sign_in_bloc.dart';

@immutable
sealed class GoogleSignInEvent {}

class ClickGoogleSignIn extends GoogleSignInEvent{
  final String googleToken;

  ClickGoogleSignIn({required this.googleToken});
}