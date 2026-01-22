import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'org_categories_event.dart';
part 'org_categories_state.dart';

class OrgCategoriesBloc extends Bloc<OrgCategoriesEvent, OrgCategoriesState> {
  final ApiController apiController;
  final List<dynamic> orgCategoriesList = [];
  OrgCategoriesBloc({required this.apiController}) : super(OrgCategoriesInitial()) {
    on<FetchOrgCategories>((event, emit) async {
      emit(OrgCategoriesLoading());
      try {
        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ----- access token data base -------
        final token = await DBHelper().getToken();


        final response = await apiController.getMethodWithoutBody(
          endPoint: 'master/org-categories',
          token: token!,
        );
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {

            orgCategoriesList.clear();
            orgCategoriesList.addAll(responseBody['data']);
            emit(
              OrgCategoriesSuccess(
                orgCategoriesList: List.from(orgCategoriesList),
              ),
            );
          } else {
            emit(OrgCategoriesFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(OrgCategoriesFail(errorMessage: error));
      } catch (e) {
        emit(
          OrgCategoriesFail(errorMessage: ConfigMessage().unexpectedErrorMsg),
        );
      }
    });
  }
}
