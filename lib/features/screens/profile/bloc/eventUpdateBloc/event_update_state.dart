part of 'event_update_bloc.dart';

@immutable
sealed class EventUpdateState {}

final class EventUpdateInitial extends EventUpdateState {}

class CarouselUpdateLoading extends EventUpdateState{}

class CarouselUpdateSuccess extends EventUpdateState{}

class CarouselUpdateFail extends EventUpdateState{
  final String errorMessage;

  CarouselUpdateFail({required this.errorMessage});
}