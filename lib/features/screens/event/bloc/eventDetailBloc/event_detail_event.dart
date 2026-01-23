part of 'event_detail_bloc.dart';

@immutable
sealed class EventDetailEvent {}

class ClickEventDetail extends EventDetailEvent{
  final String slug;

  ClickEventDetail({required this.slug});
}