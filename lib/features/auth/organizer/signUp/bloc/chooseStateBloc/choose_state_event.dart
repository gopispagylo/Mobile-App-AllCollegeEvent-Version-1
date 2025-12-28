part of 'choose_state_bloc.dart';

@immutable
sealed class ChooseStateEvent {}

class FetchChooseState extends ChooseStateEvent{
  final String countryCode;

  FetchChooseState({required this.countryCode});
}