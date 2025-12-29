part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState{}

class CategoriesSuccess extends CategoriesState{
  final List<dynamic> categoriesList;

  CategoriesSuccess({required this.categoriesList});
}

class CategoriesFail extends CategoriesState{
  final String errorMessage;

  CategoriesFail({required this.errorMessage});
}