part of 'saved_event_bloc.dart';

@immutable
sealed class SavedEventState {}

final class SavedEventInitial extends SavedEventState {}

class SavedEventLoading extends SavedEventState{}

class SavedEventSuccess extends SavedEventState{
  final List<dynamic> savedEventList;

  SavedEventSuccess({required this.savedEventList});
}

class SavedEventFail extends SavedEventState{
  final String errorMessage;

  SavedEventFail({required this.errorMessage});
}