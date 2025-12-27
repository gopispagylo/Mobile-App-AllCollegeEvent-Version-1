part of 'ace_categories_bloc.dart';

@immutable
sealed class AceCategoriesState {}

final class AceCategoriesInitial extends AceCategoriesState {}

class AceCategoriesLoading extends AceCategoriesState{}

class AceCategoriesSuccess extends AceCategoriesState{
  final List<dynamic> aceCategoriesList;

  AceCategoriesSuccess({required this.aceCategoriesList});
}

class AceCategoriesFail extends AceCategoriesState{
  final String errorMessage;

  AceCategoriesFail({required this.errorMessage});
}