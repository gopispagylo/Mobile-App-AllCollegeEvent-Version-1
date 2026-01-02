part of 'event_create_bloc.dart';

@immutable
sealed class EventCreateState {}

final class EventCreateInitial extends EventCreateState {}

class EventCreateLoading extends EventCreateState{}

class EventCreateSuccess extends EventCreateState{}

class EventCreateFail extends EventCreateState{
  final String errorMessage;

  EventCreateFail({required this.errorMessage});
}