part of 'certification_bloc.dart';

@immutable
sealed class CertificationState {}

final class CertificationInitial extends CertificationState {}

class CertificationLoading extends CertificationState{}

class CertificationSuccess extends CertificationState{
  final List<dynamic> certificationList;

  CertificationSuccess({required this.certificationList});
}

class CertificationFail extends CertificationState{
  final String errorMessage;

  CertificationFail({required this.errorMessage});
}