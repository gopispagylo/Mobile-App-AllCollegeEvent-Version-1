part of 'trending_event_list_bloc.dart';

@immutable
sealed class TrendingEventListEvent {}

class FetchTrendingEventList extends TrendingEventListEvent {
  final bool isLogin;
  final bool loadMore;

  FetchTrendingEventList({required this.isLogin, this.loadMore = false});
}
