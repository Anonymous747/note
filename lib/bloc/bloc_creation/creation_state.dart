import 'package:equatable/equatable.dart';
import 'package:note/model/element_note.dart';

abstract class CreationState extends Equatable {
  const CreationState();

  @override
  List<Object> get props => [];
}

class CreationInitial extends CreationState {}

class CreationSuccess extends CreationState {
  final ElementNote note;

  CreationSuccess({this.note});

  @override
  List<Object> get props => [this.note];
}

class CreationMoveToNote extends CreationState {
  final ElementNote note;

  CreationMoveToNote({this.note});

  @override
  // TODO: implement props
  List<Object> get props => [this.note];
}
