part of 'my_event_bloc.dart';

@immutable
sealed class MyEventState {}

final class MyEventInitial extends MyEventState {}

class MyEventLoading extends MyEventState{}

class MyEventSuccess extends MyEventState{
  final List<dynamic> myEvent;

  MyEventSuccess({required this.myEvent});
}

class MyEventFail extends MyEventState{
  final String errorMessage;

  MyEventFail({required this.errorMessage});
}
