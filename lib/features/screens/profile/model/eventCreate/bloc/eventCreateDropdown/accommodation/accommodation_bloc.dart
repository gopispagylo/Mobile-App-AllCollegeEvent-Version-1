import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'accommodation_event.dart';
part 'accommodation_state.dart';

class AccommodationBloc extends Bloc<AccommodationEvent, AccommodationState> {
  AccommodationBloc() : super(AccommodationInitial()) {
    on<AccommodationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
