part of 'virtual_event_bloc.dart';

@immutable
sealed class VirtualEventState {}

final class VirtualEventInitial extends VirtualEventState {}

class VirtualEventListLoading extends VirtualEventState {}

class VirtualEventListSuccess extends VirtualEventState {
  final List<dynamic> virtualEventList;
  final bool hasMore;

  VirtualEventListSuccess({
    required this.virtualEventList,
    required this.hasMore,
  });
}

class VirtualEventListFail extends VirtualEventState {
  final String errorMessage;

  VirtualEventListFail({required this.errorMessage});
}
