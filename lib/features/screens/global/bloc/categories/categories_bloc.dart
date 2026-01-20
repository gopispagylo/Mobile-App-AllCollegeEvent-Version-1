import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ApiController apiController;
  final List<dynamic> categoriesList = [];
  CategoriesBloc({required this.apiController}) : super(CategoriesInitial()) {
    on<FetchCategories>((event, emit) async{

      emit(CategoriesLoading());

      try{

        // --------- set a base url -------
        await apiController.setBaseUrl();

        final response = await apiController.getMethodWithoutBody(endPoint: 'master/categories', token: "token");

        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            categoriesList.clear();
            categoriesList.addAll(responseBody['data']);
            if(categoriesList.isNotEmpty){
              emit(CategoriesSuccess(categoriesList: List.from(categoriesList)));
            }else{
              emit(CategoriesFail(errorMessage: "No data found"));
            }
          }else{
            emit(CategoriesFail(errorMessage: responseBody['message']));
          }
        }
      }on DioException catch(e){
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(CategoriesFail(errorMessage: error));
      } catch(e){
        emit(CategoriesFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
