part of 'event_like_bloc.dart';

@immutable
sealed class EventLikeEvent {}

class ClickEventLike extends EventLikeEvent{
  final String eventId;

  ClickEventLike({required this.eventId});
}
