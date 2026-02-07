part of 'trending_event_list_bloc.dart';

@immutable
sealed class TrendingEventListEvent {}

class FetchTrendingEventList extends TrendingEventListEvent {
  final bool isLogin;
  final int page;
  final int limit;

  FetchTrendingEventList({
    required this.isLogin,
    required this.page,
    required this.limit,
  });
}
