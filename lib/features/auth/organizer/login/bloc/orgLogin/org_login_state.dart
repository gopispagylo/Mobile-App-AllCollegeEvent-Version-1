part of 'org_login_bloc.dart';

@immutable
sealed class OrgLoginState {}

final class OrgLoginInitial extends OrgLoginState {}


class OrgLoading extends OrgLoginState{}

class OrgSuccess extends OrgLoginState{}

class OrgFail extends OrgLoginState{
  final String errorMessage;

  OrgFail({required this.errorMessage});
}