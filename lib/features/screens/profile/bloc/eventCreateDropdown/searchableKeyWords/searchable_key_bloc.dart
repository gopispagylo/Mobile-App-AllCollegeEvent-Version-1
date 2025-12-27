import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'searchable_key_event.dart';
part 'searchable_key_state.dart';

class SearchableKeyBloc extends Bloc<SearchableKeyEvent, SearchableKeyState> {
  SearchableKeyBloc() : super(SearchableKeyInitial()) {
    final List<String> searchableKey = [];
    on<ClickSearchableKey>((event, emit) {
      emit(SearchableKeyLoading());
      try{
        searchableKey.add(event.searchableText);
        emit(AddSuccess(searchableKeyList: List.from(searchableKey)));
      }catch(e){
        emit(AddFail(errorMessage: "Fail to add"));
      }
    });
    on<RemoveClickSearchableKey>((event,emit){
      searchableKey.removeAt(event.index);
      emit(AddSuccess(searchableKeyList: List.from(searchableKey)));
    });

    on<BackendValue>((event,emit){
      searchableKey.addAll(event.searchValues);
      emit(AddSuccess(searchableKeyList: List.from(event.searchValues)));
    });
  }
}