import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'perks_event.dart';
part 'perks_state.dart';

class PerksBloc extends Bloc<PerksEvent, PerksState> {
  final ApiController apiController;
  final List<dynamic> perksList = [];
  PerksBloc({required this.apiController}) : super(PerksInitial()) {
    on<FetchPerks>((event, emit) async{
      emit(PerksLoading());
      try{

        // --------- set a base url -------
        await apiController.setBaseUrl();

        // ----- access token data base -------
        final token = await DBHelper().getToken();

        final response = await apiController.getMethodWithoutBody(endPoint: 'master/perks', token: token!);
        print("PerksBlocPerksBlocPerksBlocPerksBlocPerksBlocPerksBlocPerksBloc$response");
        if(response.statusCode == 200){
          final responseBody = response.data;
          if(responseBody['status'] == true){
            perksList.clear();
            perksList.addAll(responseBody['data']);
            emit(PerksSuccess(perksList: List.from(perksList)));
          }else{
            emit(PerksFail(errorMessage: responseBody['message']));
          }
        }

      }on DioException catch(e){
        // ------ error handle config --------
        final error = HandleErrorConfig().handleDioError(e);
        emit(PerksFail(errorMessage: error));
      } catch(e){
        emit(PerksFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });
  }
}
