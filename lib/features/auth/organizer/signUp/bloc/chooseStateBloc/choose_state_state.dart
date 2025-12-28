part of 'choose_state_bloc.dart';

@immutable
sealed class ChooseStateState {}

final class ChooseStateInitial extends ChooseStateState {}

class ChooseStateLoading extends ChooseStateState{}

class ChooseStateSuccess extends ChooseStateState{
  final List<dynamic> stateList;

  ChooseStateSuccess({required this.stateList});
}

class ChooseStateFail extends ChooseStateState{
  final String errorMessage;

  ChooseStateFail({required this.errorMessage});
}