part of 'adding_note_bloc.dart';

abstract class AddingNoteState extends Equatable {
  const AddingNoteState();
}

class AddingNoteInitial extends AddingNoteState {
  @override
  List<Object> get props => [];
}
