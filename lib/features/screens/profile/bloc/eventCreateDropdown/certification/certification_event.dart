part of 'certification_bloc.dart';

@immutable
sealed class CertificationEvent {}

class FetchCertification extends CertificationEvent{}