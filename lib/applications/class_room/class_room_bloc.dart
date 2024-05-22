import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'class_room_event.dart';
part 'class_room_state.dart';

class ClassRoomBloc extends Bloc<ClassRoomEvent, ClassRoomState> {
  ClassRoomBloc() : super(ClassRoomInitial()) {
    on<ClassRoomEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
