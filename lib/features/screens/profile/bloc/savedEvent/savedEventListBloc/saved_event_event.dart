part of 'saved_event_bloc.dart';

@immutable
sealed class SavedEventEvent {}

class FetchSavedEvent extends SavedEventEvent{}