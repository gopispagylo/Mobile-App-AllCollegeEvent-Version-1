import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'event_create_event.dart';
part 'event_create_state.dart';

class EventCreateBloc extends Bloc<EventCreateEvent, EventCreateState> {
  final ApiController apiController;
  EventCreateBloc({required this.apiController}) : super(EventCreateInitial()) {
    on<ClickEventCreate>((event, emit) async{
      emit(EventCreateLoading());
      try{

        // ------- initiate base url -----
        await apiController.setBaseUrl();

        // -------- get a org id --------
        final orgId = await DBHelper().getUserId();

        // ------- get a token ----------
        final token = await DBHelper().getToken();

        // -------- using a form data ------
        final FormData formData = FormData();

        // ---------- basic ----------
        if (event.title.isNotEmpty) {
          formData.fields.add(MapEntry('title', event.title));
        }

        if (event.description.isNotEmpty) {
          formData.fields.add(MapEntry('description', event.description));
        }

        if (event.mode.isNotEmpty) {
          formData.fields.add(MapEntry('mode', event.mode));
        }

        if (event.categoryIdentity.isNotEmpty) {
          formData.fields.add(MapEntry('categoryIdentity', event.categoryIdentity));
        }

        if (event.eventTypeIdentity.isNotEmpty) {
          formData.fields.add(MapEntry('eventTypeIdentity', event.eventTypeIdentity));
        }

        // -------- eligibleDeptIdentities ----
        for(final eligible in event.eligibleDeptIdentities){
          formData.fields.add(MapEntry('eligibleDeptIdentities[]', eligible));
        }

        // ------- tags ------
        for(final tag in event.tags){
          formData.fields.add(MapEntry('tags[]', tag));
        }

        // ---------- collaborators ------
        for( int i = 0; i < event.collaborators.length; i++ ){
          final collaborator = event.collaborators[i];
          
          collaborator.forEach((key,value){
            if(value != null){
              formData.fields.add(MapEntry('collaborator[$i][$key]', value.toString()));
            }
          });
        }

        // ------- calendars -----
        for(int i = 0; i < event.calendars.length; i++){
          final calendar = event.calendars[i];

          calendar.forEach((key,value){
            formData.fields.add(MapEntry('calendars[$i][$key]', value.toString()));
          });
        }

        // ------- tickets -----
        for(int i = 0; i < event.tickets.length; i++){
          final ticket = event.tickets[i];
          ticket.forEach((key,value){
            formData.fields.add(MapEntry('tickets[$i][$key]', value.toString()));
          });
        }


        // ------- perkIdentities -----
        for(final perk in event.perkIdentities){
          formData.fields.add(MapEntry('perkIdentities[]', perk));
        }

        // ------- accommodationIdentities -----
        for(final accommodation in event.accommodationIdentities){
          formData.fields.add(MapEntry('accommodationIdentities[]', accommodation));
        }

        // ------- certIdentity -----
        if(event.certIdentity.isNotEmpty){
          formData.fields.add(MapEntry('certIdentity', event.certIdentity));
        }


        // if (event.bannerImages.isNotEmpty) {
        //   parameter['bannerImages'] = event.bannerImages;
        // }

        // ---------- social ----------
        if (event.socialLinks.isNotEmpty) {
          event.socialLinks.forEach((key,value){
            formData.fields.add(MapEntry('socialLinks[$key]', value.toString()));
          });
        }

        // ---------- payment ----------
        if (event.paymentLink.isNotEmpty) {
          formData.fields.add(MapEntry('paymentLink', event.paymentLink));
        }


        for (var field in formData.fields) {
          print("EventCreateBlocEventCreateBlocEventCreateBlocEventCreateBlocEventCreateBloc${field.key}: ${field.value}");
        }

        final response = await apiController.postMethodWithFormData(endPoint: "organizations/$orgId/events", token: token!, data: formData);


        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['success'] == true){
            emit(EventCreateSuccess());
          } else{
            emit(EventCreateFail(errorMessage: responseBody['message']));
          }
        }
      }on DioException catch (e){
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(EventCreateFail(errorMessage: error));
      }catch (e){
        emit(EventCreateFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
