import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'choose_state_event.dart';
part 'choose_state_state.dart';

class ChooseStateBloc extends Bloc<ChooseStateEvent, ChooseStateState> {
  ChooseStateBloc() : super(ChooseStateInitial()) {
    on<ChooseStateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
