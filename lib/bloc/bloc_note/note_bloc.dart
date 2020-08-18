import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:note/bloc/bloc_note/bloc.dart';
import 'package:note/model/element_note.dart';
import 'package:note/repository/remote_data_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final RemDataRepImpl repository;

  NoteBloc({@required this.repository}) : super(NoteInitState());

  @override
  Stream<NoteState> mapEventToState(
    NoteEvent event,
  ) async* {
    if (event is FetchNotes) {
      yield NoteLoadingState();
      try {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        int colorIndex = sharedPreferences.getInt('color');
        List<ElementNote> data = await repository.fetchNotes();
        yield NoteLoadedState(element: data, colorIndex: colorIndex);
      } on PlatformException catch (e) {
        yield NoteErrorState(message: e.message);
      }
    }
  }
}
