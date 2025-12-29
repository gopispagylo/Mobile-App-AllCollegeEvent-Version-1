part of 'create_event_bloc.dart';

@immutable
sealed class CreateEventEvent {}

class ClickedEvent extends CreateEventEvent{

}