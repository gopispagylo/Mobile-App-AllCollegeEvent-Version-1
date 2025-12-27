part of 'org_categories_bloc.dart';

@immutable
sealed class OrgCategoriesState {}

final class OrgCategoriesInitial extends OrgCategoriesState {}

class OrgCategoriesLoading extends OrgCategoriesState{}

class OrgCategoriesSuccess extends OrgCategoriesState{
  final List<dynamic> orgCategoriesList;

  OrgCategoriesSuccess({required this.orgCategoriesList});
}

class OrgCategoriesFail extends OrgCategoriesState{
  final String errorMessage;

  OrgCategoriesFail({required this.errorMessage});
}