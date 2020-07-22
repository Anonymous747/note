import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'adding_note_event.dart';
part 'adding_note_state.dart';

class AddingNoteBloc extends Bloc<AddingNoteEvent, AddingNoteState> {
  AddingNoteBloc() : super(AddingNoteInitial());

  @override
  Stream<AddingNoteState> mapEventToState(
    AddingNoteEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
