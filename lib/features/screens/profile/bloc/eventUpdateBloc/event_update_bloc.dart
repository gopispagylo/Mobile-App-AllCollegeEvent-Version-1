import 'dart:convert';

import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';

part 'event_update_event.dart';
part 'event_update_state.dart';

class EventUpdateBloc extends Bloc<EventUpdateEvent, EventUpdateState> {
  final ApiController apiController;
  EventUpdateBloc({required this.apiController}) : super(EventUpdateInitial()) {
    on<ClickCarouselUpdate>((event, emit) async{

      emit(CarouselUpdateLoading());

      try {

        await apiController.setBaseUrl();

        final token = await DBHelper().getToken();

        final FormData formData = FormData();


        // ------- multiple image -------
        if (event.bannerImages.isNotEmpty) {
          List<MultipartFile> multipartFiles = event.bannerImages.map((file) {
            return MultipartFile.fromFileSync(
              file.path!,
              filename: file.name,
            );
          }).toList();

          formData.files.addAll(
              multipartFiles.map((file) => MapEntry("bannerImages", file))
          );
        }

        final response = await apiController.putMethodWithForm(endPoint: 'events/${event.eventId}', token: token!, data: formData);

        print("EventUpdateBlocEventUpdateBlocEventUpdateBlocEventUpdateBloc$response");

        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['success'] == true){
            emit(CarouselUpdateSuccess());
          } else{
            emit(CarouselUpdateFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        print("DioExceptionDioExceptionDioException$e");
        final error = HandleErrorConfig().handleDioError(e);
        emit(CarouselUpdateFail(errorMessage: error));
      } catch (e) {
        print("DioExceptionDioExceptionDioException$e");
        emit(CarouselUpdateFail(
          errorMessage: ConfigMessage().unexpectedErrorMsg,
        ));
      }
    });
  }
}
