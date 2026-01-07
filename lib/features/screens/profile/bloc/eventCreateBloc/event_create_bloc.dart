import 'dart:convert';

import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';

part 'event_create_event.dart';
part 'event_create_state.dart';

class EventCreateBloc extends Bloc<EventCreateEvent, EventCreateState> {
  final ApiController apiController;

  EventCreateBloc({required this.apiController})
      : super(EventCreateInitial()) {
    on<ClickEventCreate>(_onCreateEvent);
  }

  Future<void> _onCreateEvent(
      ClickEventCreate event, Emitter<EventCreateState> emit) async {
    emit(EventCreateLoading());

    try {
      await apiController.setBaseUrl();

      final orgId = await DBHelper().getUserId();

      final token = await DBHelper().getToken();

      final FormData formData = FormData();

      // ---------------- BASIC ----------------
      formData.fields.addAll([
        MapEntry('title', event.title),
        MapEntry('description', event.description),
        MapEntry('mode', event.mode),
        MapEntry('eventLink', event.eventLink),
        MapEntry('categoryIdentity', event.categoryIdentity),
        MapEntry('eventTypeIdentity', event.eventTypeIdentity),
        MapEntry('certIdentity', event.certIdentity),
        MapEntry('paymentLink', event.paymentLink),
      ]);

      // ---------------- ARRAYS (JSON STRING) ----------------
      formData.fields.addAll([
        MapEntry('eligibleDeptIdentities', jsonEncode(event.eligibleDeptIdentities)),
        MapEntry('tags', jsonEncode(event.tags)),
        MapEntry('perkIdentities', jsonEncode(event.perkIdentities)),
        MapEntry('accommodationIdentities', jsonEncode(event.accommodationIdentities)),
      ]);


      // ---------------- OBJECTS / LIST OF MAPS ----------------
      formData.fields.addAll([
        MapEntry('collaborators', jsonEncode(event.collaborators)),
        MapEntry('calendars', jsonEncode(event.calendars)),
        MapEntry('tickets', jsonEncode(event.tickets)),
      ]);

      // --------------- event details -------------
      formData.fields.add(
        MapEntry("location", jsonEncode(event.location))
      );

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


      // ---------------- DEBUG LOG ----------------
      for (var field in formData.fields) {
        print("EventCreate => ${field.key}: ${field.value}");
      }

      final response = await apiController.postMethodWithFormData(
        endPoint: "organizations/$orgId/events",
        token: token!,
        data: formData,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        emit(EventCreateSuccess());
      } else {
        emit(EventCreateFail(
          errorMessage: response.data['message'] ??
              ConfigMessage().unexpectedErrorMsg,
        ));
      }
    } on DioException catch (e) {
      print("DioExceptionDioExceptionDioException$e");
      final error = HandleErrorConfig().handleDioError(e);
      emit(EventCreateFail(errorMessage: error));
    } catch (e) {
      print("DioExceptionDioExceptionDioException$e");
      emit(EventCreateFail(
        errorMessage: ConfigMessage().unexpectedErrorMsg,
      ));
    }
  }
}

