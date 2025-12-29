import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  CreateEventBloc() : super(CreateEventInitial()) {
    on<CreateEventEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
