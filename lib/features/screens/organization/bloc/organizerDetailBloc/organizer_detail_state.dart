part of 'organizer_detail_bloc.dart';

@immutable
sealed class OrganizerDetailState {}

final class OrganizerDetailInitial extends OrganizerDetailState {}


class OrganizerDetailLoading extends OrganizerDetailState{}

  class OrganizerDetailSuccess extends OrganizerDetailState{
  final List<dynamic> organizerDetailList;

  OrganizerDetailSuccess({required this.organizerDetailList});
}

class OrganizerDetailFail extends OrganizerDetailState{
  final String errorMessage;

  OrganizerDetailFail({required this.errorMessage});
}