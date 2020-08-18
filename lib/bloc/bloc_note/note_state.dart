import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:note/model/element_note.dart';

abstract class NoteState extends Equatable {}

class NoteInitState extends NoteState {
  @override
  List<Object> get props => [];
}

class NoteLoadingState extends NoteState {
  @override
  List<Object> get props => [];
}

class NoteLoadedState extends NoteState {
  final List<ElementNote> element;
  final int colorIndex;

  NoteLoadedState({@required this.element, this.colorIndex});

  @override
  List<Object> get props => [this.element, this.colorIndex ?? 0];
}

class NoteErrorState extends NoteState {
  final String message;

  NoteErrorState({@required this.message});

  @override
  List<Object> get props => [this.message];
}
