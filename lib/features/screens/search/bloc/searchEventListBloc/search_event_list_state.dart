part of 'search_event_list_bloc.dart';

@immutable
sealed class SearchEventListState {}

final class SearchEventListInitial extends SearchEventListState {}

class SearchEventListLoading extends SearchEventListState{}

class SearchEventListSuccess extends SearchEventListState{
  final List<dynamic> searchEventList;

  SearchEventListSuccess({required this.searchEventList});
}

class SearchEventListFail extends SearchEventListState{
  final String errorMessage;

  SearchEventListFail({required this.errorMessage});
}