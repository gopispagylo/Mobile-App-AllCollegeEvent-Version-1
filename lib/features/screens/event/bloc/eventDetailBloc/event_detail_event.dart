part of 'event_detail_bloc.dart';

@immutable
sealed class EventDetailEvent {}

class ClickEventDetail extends EventDetailEvent {
  final String slug;
  final bool isLogin;

  ClickEventDetail({required this.slug, required this.isLogin});
}
