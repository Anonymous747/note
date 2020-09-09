import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:note/model/element_note.dart';

abstract class AccountCreationEvent extends Equatable {
  const AccountCreationEvent();

  @override
  List<Object> get props => [];
}

class AccountCreationInitialEvent extends AccountCreationEvent {
  final BuildContext context;
  final int colorIndex;

  const AccountCreationInitialEvent({this.context, this.colorIndex});

  @override
  List<Object> get props => [this.context, this.colorIndex];

  @override
  String toString() => 'AccountCreationInitialEvent';
}

class AccountNoteCreatedEvent extends AccountCreationEvent {
  final BuildContext context;
  final int colorIndex;
  final ElementNote note;

  const AccountNoteCreatedEvent({this.context, this.colorIndex, this.note});

  @override
  List<Object> get props => [this.context, this.colorIndex, this.note];

  @override
  String toString() => 'AccountNoteCreatedEvent';
}

class AccountContinueEvent extends AccountCreationEvent {
  final BuildContext context;
  final int colorIndex;
  final ElementNote note;

  const AccountContinueEvent({this.context, this.colorIndex, this.note});

  @override
  List<Object> get props => [this.context, this.colorIndex, this.note];

  @override
  String toString() => 'AccountContinueEvent';
}

class AccountRegistrationEvent extends AccountCreationEvent {}
