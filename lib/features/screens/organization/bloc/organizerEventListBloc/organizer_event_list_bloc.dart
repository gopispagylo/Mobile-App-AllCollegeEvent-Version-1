import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'organizer_event_list_event.dart';
part 'organizer_event_list_state.dart';

class OrganizerEventListBloc
    extends Bloc<OrganizerEventListEvent, OrganizerEventListState> {
  final ApiController apiController;
  final List<dynamic> organizerEventList = [];
  OrganizerEventListBloc({required this.apiController})
    : super(OrganizerEventListInitial()) {
    on<FetchOrganizerEvent>((event, emit) async {
      emit(OrganizerEventLoading());

      try {
        // initial set a base url
        await apiController.setBaseUrl();
        // ------- token -----------
        final token = await DBHelper().getToken();

        final response = event.isLogin
            ? await apiController.getMethodWithoutBody(
                endPoint: "organizations/${event.slug}/events",
                token: token!,
              )
            : await apiController.getMethodWithoutBodyAndHeader(
                endPoint: "organizations/${event.slug}/events",
              );
        print(
          "OrganizerEventListBlocOrganizerEventListBlocOrganizerEventListBlocOrganizerEventListBloc$response",
        );
        if (response.statusCode == 200) {
          final responseBody = response.data;
          if (responseBody['status'] == true) {
            print(
              'EventListBlocEventListBlocEventListBlocEventListBloc$response',
            );
            organizerEventList.clear();
            organizerEventList.addAll(responseBody['data']);
            if (responseBody['data'].isNotEmpty) {
              emit(
                OrganizerEventSuccess(
                  organizerEventList: List.from(organizerEventList),
                ),
              );
            } else {
              emit(OrganizerEventFail(errorMessage: "No data found"));
            }
          } else {
            emit(OrganizerEventFail(errorMessage: responseBody['message']));
          }
        }
      } on DioException catch (e) {
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(OrganizerEventFail(errorMessage: error));
      } catch (e) {
        emit(
          OrganizerEventFail(errorMessage: ConfigMessage().unexpectedErrorMsg),
        );
      }
    });
  }
}
