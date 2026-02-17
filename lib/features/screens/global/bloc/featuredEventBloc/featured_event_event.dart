part of 'featured_event_bloc.dart';

@immutable
sealed class FeaturedEventEvent {}

class FetchFeaturedEventList extends FeaturedEventEvent {
  final bool isLogin;
  final bool loadMore;

  FetchFeaturedEventList({required this.isLogin, this.loadMore = false});
}
