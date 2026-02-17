part of 'up_coming_event_bloc.dart';

@immutable
sealed class UpComingEventEvent {}

class FetchUpComingEventList extends UpComingEventEvent {
  final bool isLogin;
  final bool loadMore;

  FetchUpComingEventList({required this.isLogin, this.loadMore = false});
}
