part of 'perks_bloc.dart';

@immutable
sealed class PerksState {}

final class PerksInitial extends PerksState {}

class PerksLoading extends PerksState{}

class PerksSuccess extends PerksState{
  final List<dynamic> perksList;

  PerksSuccess({required this.perksList});
}

class PerksFail extends PerksState{
  final String errorMessage;

  PerksFail({required this.errorMessage});
}