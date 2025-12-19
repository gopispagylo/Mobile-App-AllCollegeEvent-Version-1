part of 'verify_otp_bloc.dart';

@immutable
sealed class VerifyOtpEvent {}

class ClickedVerifyOtp extends VerifyOtpEvent{
  final String email;
  final String otp;

  ClickedVerifyOtp({required this.email, required this.otp});
}