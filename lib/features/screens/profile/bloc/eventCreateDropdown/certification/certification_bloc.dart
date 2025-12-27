import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'certification_event.dart';
part 'certification_state.dart';

class CertificationBloc extends Bloc<CertificationEvent, CertificationState> {
  final ApiController apiController;
  final List<dynamic> certificationList = [];

  CertificationBloc({required this.apiController}) : super(CertificationInitial()) {
    on<FetchCertification>((event, emit) async {

      emit(CertificationLoading());

      try {

        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ----- access token data base -------
        final token = await DBHelper().getToken();

        final response = await apiController.getMethodWithoutBody(
          endPoint: 'master/certifications',
          token: token!,
        );
        print(
          "CertificationBlocCertificationBlocCertificationBlocCertificationBlocCertificationBlocCertificationBloc$response",
        );
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            certificationList.clear();
            certificationList.addAll(responseBody['data']);
            emit(
              CertificationSuccess(
                certificationList: List.from(certificationList),
              ),
            );
          } else {
            emit(CertificationFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(CertificationFail(errorMessage: error));
      } catch (e) {
        emit(
          CertificationFail(errorMessage: ConfigMessage().unexpectedErrorMsg),
        );
      }
    });
  }
}
