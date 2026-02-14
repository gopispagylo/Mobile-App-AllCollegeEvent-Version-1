part of 'up_coming_event_bloc.dart';

@immutable
sealed class UpComingEventEvent {}

class FetchUpComingEvent extends UpComingEventEvent {
  final bool loadMore;
  final String slug;
  final bool isLogin;

  FetchUpComingEvent({
    this.loadMore = false,
    required this.slug,
    required this.isLogin,
  });
}
