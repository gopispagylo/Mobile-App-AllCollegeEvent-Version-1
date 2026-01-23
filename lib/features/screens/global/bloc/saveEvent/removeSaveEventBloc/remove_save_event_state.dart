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

class RemoveSaveEventFail extends RemoveSaveEventState{
  final String errorMessage;

  RemoveSaveEventFail({required this.errorMessage});
}