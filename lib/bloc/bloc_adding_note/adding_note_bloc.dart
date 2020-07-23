import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note/bloc/bloc_adding_note/bloc.dart';

class AddingNoteBloc extends Bloc<AddingNoteEvent, AddingNoteState> {
  AddingNoteBloc() : super(AddingNoteInitial());

  @override
  Stream<AddingNoteState> mapEventToState(
    AddingNoteEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
