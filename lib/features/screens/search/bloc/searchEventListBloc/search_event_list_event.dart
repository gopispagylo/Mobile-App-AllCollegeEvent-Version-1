part of 'search_event_list_bloc.dart';

@immutable
sealed class SearchEventListEvent {}

class FetchSearchEventList extends SearchEventListEvent{}