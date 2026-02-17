part of 'featured_event_bloc.dart';

@immutable
sealed class FeaturedEventState {}

final class FeaturedEventInitial extends FeaturedEventState {}

class FeaturedEventListLoading extends FeaturedEventState {}

class FeaturedEventListSuccess extends FeaturedEventState {
  final List<dynamic> featuredEventList;
  final bool hasMore;

  FeaturedEventListSuccess({
    required this.featuredEventList,
    required this.hasMore,
  });
}

class FeaturedEventListFail extends FeaturedEventState {
  final String errorMessage;

  FeaturedEventListFail({required this.errorMessage});
}
