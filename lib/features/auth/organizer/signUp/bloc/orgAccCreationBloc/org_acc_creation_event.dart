part of 'org_acc_creation_bloc.dart';

@immutable
sealed class OrgAccCreationEvent {}

class ClickedOrgSignUp extends OrgAccCreationEvent{
  final String email;
  final String password;
  final String type;
  final String orgName;
  final String orgCat;
  final String country;
  final String state;
  final String city;

  ClickedOrgSignUp({required this.email, required this.password, required this.type, required this.orgName, required this.orgCat, required this.country, required this.state, required this.city});
}