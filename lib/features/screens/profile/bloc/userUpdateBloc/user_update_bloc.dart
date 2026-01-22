import 'dart:convert';

import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';

part 'user_update_event.dart';
part 'user_update_state.dart';

class UserUpdateBloc extends Bloc<UserUpdateEvent, UserUpdateState> {
  final ApiController apiController;
  UserUpdateBloc({required this.apiController}) : super(UserUpdateInitial()) {
    on<ClickUserUpdate>((event, emit) async{
      emit(UserUpdateLoading());
      try{

        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ----- access token data base -------
        final token = await DBHelper().getToken();

        // ----- get a user id -----
        final userId = await DBHelper().getUserId();

        print("userIduserIduserIduserId$userId");
        print("tokentokentokentokentoken$token");

        // -------- Build form data --------
        final formData = FormData();

        // ------- required fields -------
        if (event.whichUser.trim().isNotEmpty) {
          formData.fields.add(
            MapEntry('type', event.whichUser.trim()),
          );
        }

        formData.fields.add(
          MapEntry('identity', userId.toString()),
        );

        // ------- name / org name -------
        if (event.whichUser == 'org') {
          if (event.name.trim().isNotEmpty) {
            formData.fields.add(
              MapEntry('organizationName', event.name.trim()),
            );
          }
        } else {
          if (event.name.trim().isNotEmpty) {
            formData.fields.add(
              MapEntry('name', event.name.trim()),
            );
          }
        }

        // ------- image upload -------
        if(event.profileImage != null){
          formData.files.add(MapEntry('profileImage', await MultipartFile.fromFile(
            event.profileImage!.path!,
            filename: event.profileImage!.name
          )));
        }

        // ------- other fields -------
        print("statestatestatestatestate${event.userState}");
        if (event.userState.trim().isNotEmpty) {
          formData.fields.add(MapEntry('state', event.userState.trim()));
        }
        if (event.city.trim().isNotEmpty) {
          formData.fields.add(MapEntry('city', event.city.trim()));
        }
        if (event.country.trim().isNotEmpty) {
          formData.fields.add(MapEntry('country', event.country.trim()));
        }
        if (event.phone.trim().isNotEmpty) {
          formData.fields.add(MapEntry('phone', event.phone.trim()));
        }

        print('FORM DATA → ${formData.fields.map((e)=> e.value)}');
        print('FORM FILES → ${formData.files}');


        final response = await apiController.postMethodWithFormData(endPoint: 'auth/update-profile', token: token!, data: formData);

        print("UserUpdateBlocUserUpdateBlocUserUpdateBlocUserUpdateBlocUserUpdateBloc$response");

        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
          emit(UserUpdateSuccess());
          }else{
            emit(UserUpdateFail(errorMessage: responseBody['message']));
          }
        }
      }on DioException catch(e){
        print("kakakakakakakakakakakakak$e");
        // ------ error handle config --------
      final errorMessage =  HandleErrorConfig().handleDioError(e);
      emit(UserUpdateFail(errorMessage: errorMessage));

      } catch(e){
        print("kakakakakakakakakakakakak$e");
        emit(UserUpdateFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });

    // ---------- update social media links ----------
    on<SocialLinkOrganizer>((event, emit) async{
      emit(SocialLinkOrganizerLoading());
      try{

        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ----- access token data base -------
        final token = await DBHelper().getToken();

        // ----- get a user id -----
        final userId = await DBHelper().getUserId();

        // -------- Build form data --------
        final formData = FormData();

        // ------- social link -----------
        formData.fields.add(
          MapEntry('socialLinks', jsonEncode(event.socialLink))
        );

        if (event.whichUser.trim().isNotEmpty) {
          formData.fields.add(
            MapEntry('type', event.whichUser.trim()),
          );
        }

        formData.fields.add(
          MapEntry('identity', userId.toString()),
        );

        print(
            'FORM DATA → ${formData.fields.map((e) => '${e.key}: ${e.value}').toList()}'
        );


        final response = await apiController.postMethodWithFormData(endPoint: 'auth/update-profile', token: token!, data: formData);

        print("UserUpdateBlocUserUpdateBlocUserUpdateBlocUserUpdateBlocUserUpdateBloc$response");

        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            emit(SocialLinkOrganizerSuccess());
          }else{
            emit(SocialLinkOrganizerFail(errorMessage: responseBody['message']));
          }
        }
      }on DioException catch(e){
        print("kakakakakakakakakakakakak$e");
        // ------ error handle config --------
        final errorMessage =  HandleErrorConfig().handleDioError(e);
        emit(SocialLinkOrganizerFail(errorMessage: errorMessage));

      } catch(e){
        print("kakakakakakakakakakakakak$e");
        emit(SocialLinkOrganizerFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
