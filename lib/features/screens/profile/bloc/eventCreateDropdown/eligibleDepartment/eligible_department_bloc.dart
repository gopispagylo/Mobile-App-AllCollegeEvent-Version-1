import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'eligible_department_event.dart';
part 'eligible_department_state.dart';

class EligibleDepartmentBloc extends Bloc<EligibleDepartmentEvent, EligibleDepartmentState> {
  final ApiController apiController;
  final List<dynamic> eligibleDepartmentList = [];
  EligibleDepartmentBloc({required this.apiController}) : super(EligibleDepartmentInitial()) {
    on<FetchEligibleDepartment>((event, emit) async {

      emit(EligibleDepartmentLoading());

      try {

        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ----- access token data base -------
        final token = await DBHelper().getToken();

        final response = await apiController.getMethodWithoutBody(
          endPoint: 'master/eligible-departments',
          token: token!,
        );
        print("EligibleDepartmentBlocEligibleDepartmentBlocEligibleDepartmentBlocEligibleDepartmentBloc$response");
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            eligibleDepartmentList.clear();
            eligibleDepartmentList.addAll(responseBody['data']);
            if(eligibleDepartmentList.isNotEmpty){
              emit(EligibleDepartmentSuccess(eligibleDepartmentList: List.from(eligibleDepartmentList)),);
            }else{
              emit(EligibleDepartmentFail(errorMessage: "No date found"));
            }
          } else {
            emit(EligibleDepartmentFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {

        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(EligibleDepartmentFail(errorMessage: error));

      } catch (e) {
        emit(EligibleDepartmentFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
