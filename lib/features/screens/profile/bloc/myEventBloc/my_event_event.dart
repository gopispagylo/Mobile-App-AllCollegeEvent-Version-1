part of 'my_event_bloc.dart';

@immutable
sealed class MyEventEvent {}

class FetchMyEvent extends MyEventEvent{}
