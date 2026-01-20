part of 'event_type_all_bloc.dart';

@immutable
sealed class EventTypeAllState {}

final class EventTypeAllInitial extends EventTypeAllState {}

class EventTypeAllLoading extends EventTypeAllState{}

class EventTypeSuccessAll extends EventTypeAllState{
  final List<dynamic> eventTypeList;

  EventTypeSuccessAll({required this.eventTypeList});
}

class EventTypeFailAll extends EventTypeAllState{
  final String errorMessage;

  EventTypeFailAll({required this.errorMessage});
}