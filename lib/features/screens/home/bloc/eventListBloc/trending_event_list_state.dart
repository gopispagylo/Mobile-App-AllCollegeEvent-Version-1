part of 'trending_event_list_bloc.dart';

@immutable
sealed class TrendingEventListState {}

final class TrendingEventListInitial extends TrendingEventListState {}

class TrendingEventListLoading extends TrendingEventListState{}

class TrendingEventListSuccess extends TrendingEventListState{
  final List<dynamic> trendingEventList;

  TrendingEventListSuccess({required this.trendingEventList});
}

class TrendingEventListFail extends TrendingEventListState{
  final String errorMessage;

  TrendingEventListFail({required this.errorMessage});
}