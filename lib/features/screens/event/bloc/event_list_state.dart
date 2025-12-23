part of 'event_list_bloc.dart';

@immutable
sealed class EventListState {}

final class EventListInitial extends EventListState {}

class EventListLoading extends EventListState{}

class EventSuccess extends EventListState{
  final List<dynamic> eventList;

  EventSuccess({required this.eventList});
}

class EventFail extends EventListState{
  final String errorMessage;

  EventFail({required this.errorMessage});
}