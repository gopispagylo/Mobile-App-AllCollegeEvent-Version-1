part of 'org_login_bloc.dart';

@immutable
sealed class OrgLoginEvent {}

class ClickedOrgLogin extends OrgLoginEvent{
  final String email;
  final String password;
  final String type;

  ClickedOrgLogin({required this.email, required this.password, required this.type});
}
