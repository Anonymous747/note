import 'package:equatable/equatable.dart';
import 'package:note/model/element_note.dart';

abstract class AccountCreationState extends Equatable {
  const AccountCreationState();

  @override
  List<Object> get props => [];
}

class AccountCreationInitial extends AccountCreationState {}

class AccountCreationGreeting extends AccountCreationState {}

class AccountNoteCreatedState extends AccountCreationState {
  final ElementNote note;

  const AccountNoteCreatedState({this.note});

  @override
  List<Object> get props => [this.note];
}

class AccountContinueState extends AccountCreationState {}

class AccountCreationSuccess extends AccountCreationState {}
