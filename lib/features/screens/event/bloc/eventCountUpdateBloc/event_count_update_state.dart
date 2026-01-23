part of 'event_count_update_bloc.dart';

@immutable
sealed class EventCountUpdateState {}

final class EventCountUpdateInitial extends EventCountUpdateState {}

class EventCountUpdateLoading extends EventCountUpdateState{}

class EventCountUpdateSuccess extends EventCountUpdateState{}

class EventCountUpdateFail extends EventCountUpdateState{
  final String errorMessage;

  EventCountUpdateFail({required this.errorMessage});
}