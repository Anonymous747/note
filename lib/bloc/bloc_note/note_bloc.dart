import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:note/bloc/bloc_note/bloc.dart';
import 'package:note/model/element_note.dart';
import 'package:note/repository/user_repository.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final UserRep repository;

  NoteBloc({@required this.repository});

  @override
  NoteState get initialState => NoteInitState();

  @override
  Stream<NoteState> mapEventToState(
    NoteEvent event,
  ) async* {
    if (event is FetchNotes) {
      yield NoteLoadingState();
      try {
        List<ElementNote> data = await repository.getTask().toList();
        yield NoteLoadedState(element: data);
      } on PlatformException catch (e) {
        yield NoteErrorState(message: e.message);
      }
    }
  }
}
