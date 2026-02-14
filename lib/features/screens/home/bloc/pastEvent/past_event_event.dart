part of 'past_event_bloc.dart';

@immutable
sealed class PastEventEvent {}

class FetchPastEventList extends PastEventEvent {
  final bool loadMore;
  final String slug;

  FetchPastEventList({this.loadMore = false, required this.slug});
}
