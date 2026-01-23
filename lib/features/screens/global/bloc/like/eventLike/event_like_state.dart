part of 'event_like_bloc.dart';

@immutable
sealed class EventLikeState {}

final class EventLikeInitial extends EventLikeState {}

class EventLikeSuccess extends EventLikeState{
  final bool checkFav;
  final String id;
  final String count;

  EventLikeSuccess({required this.checkFav, required this.id, required this.count});
}

class EventLikeFail extends EventLikeState{
  final String errorMessage;
  final String id;

  EventLikeFail({required this.errorMessage,required this.id});
}