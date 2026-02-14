part of 'up_coming_event_bloc.dart';

@immutable
sealed class UpComingEventState {}

final class UpComingEventInitial extends UpComingEventState {}

class LoadingUpComingEventList extends UpComingEventState {}

class SuccessUpComingEventList extends UpComingEventState {
  final List<dynamic> upComingEventList;
  final bool hasMore;

  SuccessUpComingEventList({
    required this.upComingEventList,
    required this.hasMore,
  });
}

class FailUpComingEventList extends UpComingEventState {
  final String errorMessage;

  FailUpComingEventList({required this.errorMessage});
}
