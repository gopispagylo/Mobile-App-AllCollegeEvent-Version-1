part of 'virtual_event_bloc.dart';

@immutable
sealed class VirtualEventEvent {}

class FetchVirtualEventList extends VirtualEventEvent {
  final bool isLogin;
  final bool loadMore;

  FetchVirtualEventList({required this.isLogin, this.loadMore = false});
}
