part of 'searchable_key_bloc.dart';

@immutable
sealed class SearchableKeyState {}

final class SearchableKeyInitial extends SearchableKeyState {}

class SearchableKeyLoading extends SearchableKeyState{}

class AddSuccess extends SearchableKeyState{
  final List<String> searchableKeyList;

  AddSuccess({required this.searchableKeyList});
}

class AddFail extends SearchableKeyState{
  final String errorMessage;

  AddFail({required this.errorMessage});
}