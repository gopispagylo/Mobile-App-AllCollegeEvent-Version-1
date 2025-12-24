part of 'event_detail_bloc.dart';

@immutable
sealed class EventDetailState {}

final class EventDetailInitial extends EventDetailState {}

class EventDetailLoading extends EventDetailState{}

class EventDetailSuccess extends EventDetailState{
  final List<dynamic> eventDetailList;

  EventDetailSuccess({required this.eventDetailList});
}

class EventDetailFail extends EventDetailState{
  final String errorMessage;

  EventDetailFail({required this.errorMessage});
}