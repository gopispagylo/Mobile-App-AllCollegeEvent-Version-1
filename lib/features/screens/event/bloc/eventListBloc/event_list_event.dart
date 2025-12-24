part of 'event_list_bloc.dart';

@immutable
sealed class EventListEvent {}

class FetchEventList extends EventListEvent{}