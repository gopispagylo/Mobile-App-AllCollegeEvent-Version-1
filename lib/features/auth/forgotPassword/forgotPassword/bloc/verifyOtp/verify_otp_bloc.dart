import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final ApiController apiController;
  VerifyOtpBloc({required this.apiController}) : super(VerifyOtpInitial()) {
    on<ClickedVerifyOtp>((event, emit) async{
      emit(VerifyOtpLoading());
      try{

        // ------- trigger the base url --------
        await apiController.setBaseUrl();

        final parameter = {
          'email' : event.email,
          'otp' : event.otp
        };

        final response = await apiController.postMethod(endPoint: "auth/verify-otp", data: parameter);
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            emit(VerifyOtpSuccess());
          }else{
            emit(VerifyOtpFail(errorMessage: responseBody['message']));
          }
        }
      }on DioException catch(e){
        // ------ error handle config --------
        HandleErrorConfig().handleDioError(e);
      } catch(e){
        emit(VerifyOtpFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
