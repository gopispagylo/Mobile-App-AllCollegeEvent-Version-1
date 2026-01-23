part of 'remove_save_event_bloc.dart';

@immutable
sealed class RemoveSaveEventState {}

final class RemoveSaveEventInitial extends RemoveSaveEventState {}

class RemoveSaveEventLoading extends RemoveSaveEventState{
  final String eventId;

  RemoveSaveEventLoading({required this.eventId});

}

class RemoveSaveEventSuccess extends RemoveSaveEventState{
  final String successMessage;

  RemoveSaveEventSuccess({required this.successMessage});
}

class AddSave extends RemoveSaveEventState{
  final String eventId;
  final bool checkSave;

  AddSave({required this.eventId, required this.checkSave});
}

class RemoveSaveEventFail extends RemoveSaveEventState{
  final String errorMessage;
  final String eventId;

  RemoveSaveEventFail({required this.errorMessage, required this.eventId});
}