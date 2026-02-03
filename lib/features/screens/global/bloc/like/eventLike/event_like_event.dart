part of 'event_like_bloc.dart';

@immutable
sealed class EventLikeEvent {}

class ClickEventLike extends EventLikeEvent {
  final String eventId;
  final bool initialFav;
  final int initialCount;

  ClickEventLike({
    required this.eventId,
    required this.initialFav,
    required this.initialCount,
  });
}
