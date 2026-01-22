part of 'remove_save_event_bloc.dart';

@immutable
sealed class RemoveSaveEventEvent {}

class ClickRemoveSaveEvent extends RemoveSaveEventEvent{
  final String eventId;

  ClickRemoveSaveEvent({required this.eventId});
}