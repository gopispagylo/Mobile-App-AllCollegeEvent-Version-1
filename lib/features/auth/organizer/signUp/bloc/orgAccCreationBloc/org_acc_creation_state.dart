part of 'org_acc_creation_bloc.dart';

@immutable
sealed class OrgAccCreationState {}

final class OrgAccCreationInitial extends OrgAccCreationState {}

class OrgSignUpLoading extends OrgAccCreationState{}

class OrgSignUpSuccess extends OrgAccCreationState{}

class OrgSignUpFail extends OrgAccCreationState{
  final String errorMessage;

  OrgSignUpFail({required this.errorMessage});
}