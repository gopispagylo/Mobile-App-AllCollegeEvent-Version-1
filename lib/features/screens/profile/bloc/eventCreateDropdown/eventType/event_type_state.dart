part of 'event_type_bloc.dart';

@immutable
sealed class EventTypeState {}

final class EventTypeInitial extends EventTypeState {}

class EventTypeLoading extends EventTypeState{}

class EventTypeSuccess extends EventTypeState{
  final List<dynamic> eventTypeList;

  EventTypeSuccess({required this.eventTypeList});
}

class EventTypeFail extends EventTypeState{
  final String errorMessage;

  EventTypeFail({required this.errorMessage});
}