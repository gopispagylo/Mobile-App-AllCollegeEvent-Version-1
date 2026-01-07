part of 'event_create_bloc.dart';

@immutable
sealed class EventCreateEvent {}

class ClickEventCreate extends EventCreateEvent {

  final String title;
  final String description;
  final String mode;
  final String categoryIdentity;
  final String eventTypeIdentity;
  final String eventLink;


  final List<String> eligibleDeptIdentities;
  final List<String> tags;

  final List<Map<String, dynamic>> collaborators;
  final List<Map<String, dynamic>> calendars;
  final List<Map<String, dynamic>> tickets;

  final List<String> perkIdentities;
  final String certIdentity;
  final List<String> accommodationIdentities;

  final String paymentLink;

  final Map<String, dynamic> socialLinks;
  final Map<String, dynamic> location;

  final List<PlatformFile> bannerImages;

  ClickEventCreate({
    required this.title,
    required this.description,
    required this.mode,
    required this.categoryIdentity,
    required this.eventTypeIdentity,
    required this.eventLink,
    required this.certIdentity,
    required this.eligibleDeptIdentities,
    required this.tags,
    required this.collaborators,
    required this.calendars,
    required this.tickets,
    required this.perkIdentities,
    required this.accommodationIdentities,
    required this.paymentLink,
    required this.socialLinks,
    required this.location,
    required this.bannerImages,
  });
}
