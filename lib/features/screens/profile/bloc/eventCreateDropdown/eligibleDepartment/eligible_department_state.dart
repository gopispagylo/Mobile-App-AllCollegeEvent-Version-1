part of 'eligible_department_bloc.dart';

@immutable
sealed class EligibleDepartmentState {}

final class EligibleDepartmentInitial extends EligibleDepartmentState {}

class EligibleDepartmentLoading extends EligibleDepartmentState{}

class EligibleDepartmentSuccess extends EligibleDepartmentState{
  final List<dynamic> eligibleDepartmentList;

  EligibleDepartmentSuccess({required this.eligibleDepartmentList});
}

class EligibleDepartmentFail extends EligibleDepartmentState{
  final String errorMessage;

  EligibleDepartmentFail({required this.errorMessage});
}