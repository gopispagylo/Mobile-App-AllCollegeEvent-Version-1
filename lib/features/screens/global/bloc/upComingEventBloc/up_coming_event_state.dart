part of 'up_coming_event_bloc.dart';

@immutable
sealed class UpComingEventState {}

final class UpComingEventInitial extends UpComingEventState {}

class UpComingEventListLoading extends UpComingEventState {}

class UpComingEventListSuccess extends UpComingEventState {
  final List<dynamic> upComingEventList;
  final bool hasMore;

  UpComingEventListSuccess({
    required this.upComingEventList,
    required this.hasMore,
  });
}

class UpComingEventListFail extends UpComingEventState {
  final String errorMessage;

  UpComingEventListFail({required this.errorMessage});
}
