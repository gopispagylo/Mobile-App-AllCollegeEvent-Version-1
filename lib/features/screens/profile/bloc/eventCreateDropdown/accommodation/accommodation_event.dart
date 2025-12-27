part of 'accommodation_bloc.dart';

@immutable
sealed class AccommodationEvent {}

class FetchAccommodation extends AccommodationEvent{}