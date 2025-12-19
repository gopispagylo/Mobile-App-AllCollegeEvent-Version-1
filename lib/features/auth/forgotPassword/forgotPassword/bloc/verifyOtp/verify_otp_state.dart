part of 'verify_otp_bloc.dart';

@immutable
sealed class VerifyOtpState {}

final class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState{}

class VerifyOtpSuccess extends VerifyOtpState{}

class VerifyOtpFail extends VerifyOtpState{
  final String errorMessage;

  VerifyOtpFail({required this.errorMessage});
}