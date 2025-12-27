part of 'event_type_bloc.dart';

@immutable
sealed class EventTypeEvent {}

class ClickedEventType extends EventTypeEvent{
  final String identity;

  ClickedEventType({required this.identity});
}