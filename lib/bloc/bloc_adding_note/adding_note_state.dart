import 'package:equatable/equatable.dart';

abstract class AddingNoteState extends Equatable {
  const AddingNoteState();
}

class AddingNoteInitial extends AddingNoteState {
  @override
  List<Object> get props => [];
}
