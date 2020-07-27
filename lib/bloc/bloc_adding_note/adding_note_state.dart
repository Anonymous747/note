import 'package:equatable/equatable.dart';

abstract class AddingNoteState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddingNoteInitial extends AddingNoteState {}

class AddingNoteLoading extends AddingNoteState {}

class AddingNoteLoaded extends AddingNoteState {}

class AddingNoteFailure extends AddingNoteState {
  final String message;

  AddingNoteFailure({this.message});

  @override
  List<Object> get props => [this.message];
}
