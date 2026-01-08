part of 'event_update_bloc.dart';

@immutable
sealed class EventUpdateEvent {}

class ClickCarouselUpdate extends EventUpdateEvent{
  final String eventId;
  final List<PlatformFile> bannerImages;

  ClickCarouselUpdate({required this.eventId, required this.bannerImages});
}
