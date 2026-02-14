part of 'past_event_bloc.dart';

@immutable
sealed class PastEventState {}

final class PastEventInitial extends PastEventState {}

class LoadingPastEventList extends PastEventState {}

class SuccessPastEventList extends PastEventState {
  final List<dynamic> pastEventList;
  final bool hasMore;

  SuccessPastEventList({required this.pastEventList, required this.hasMore});
}

class FailPastEventList extends PastEventState {
  final String errorMessage;

  FailPastEventList({required this.errorMessage});
}
