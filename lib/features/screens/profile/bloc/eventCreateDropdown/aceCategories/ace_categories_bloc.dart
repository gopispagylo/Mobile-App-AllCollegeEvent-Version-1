import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'ace_categories_event.dart';
part 'ace_categories_state.dart';

class AceCategoriesBloc extends Bloc<AceCategoriesEvent, AceCategoriesState> {
  final ApiController apiController;
  final List<dynamic> aceCategoriesList = [];
  AceCategoriesBloc({required this.apiController}) : super(AceCategoriesInitial()) {
    on<FetchAceCategories>((event, emit) async {
      emit(AceCategoriesLoading());
      try {
        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ----- access token data base -------
        final token = await DBHelper().getToken();

        final response = await apiController.getMethodWithoutBody(
          endPoint: 'master/categories',
          token: token!,
        );
        print(
          "AceCategoriesBlocAceCategoriesBlocAceCategoriesBlocAceCategoriesBlocAceCategoriesBlocAceCategoriesBloc$response",
        );
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['success'] == true) {
            aceCategoriesList.clear();
            aceCategoriesList.addAll(responseBody['data']);
            emit(
              AceCategoriesSuccess(
                aceCategoriesList: List.from(aceCategoriesList),
              ),
            );
          } else {
            emit(AceCategoriesFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(AceCategoriesFail(errorMessage: error));
      } catch (e) {
        emit(
          AceCategoriesFail(errorMessage: ConfigMessage().unexpectedErrorMsg),
        );
      }
    });
  }
}
