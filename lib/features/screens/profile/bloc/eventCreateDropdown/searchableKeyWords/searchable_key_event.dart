
part of 'searchable_key_bloc.dart';

@immutable
sealed class SearchableKeyEvent {}

class ClickSearchableKey extends SearchableKeyEvent{
  final String searchableText;

  ClickSearchableKey({required this.searchableText});
}

class RemoveClickSearchableKey extends SearchableKeyEvent{
  final int index;

  RemoveClickSearchableKey({required this.index});
}

class BackendValue extends SearchableKeyEvent{
  final Set<String> searchValues;

  BackendValue({required this.searchValues});
}
