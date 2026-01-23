part of 'event_count_update_bloc.dart';

@immutable
sealed class EventCountUpdateEvent {}

class ClickEventCountUpdate extends EventCountUpdateEvent{
  final String slug;

  ClickEventCountUpdate({required this.slug});
}