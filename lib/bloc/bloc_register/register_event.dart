import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:note/model/element_note.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterInitialEvent extends RegisterEvent {
  final BuildContext context;
  final int colorIndex;

  const RegisterInitialEvent({this.context, this.colorIndex});

  @override
  List<Object> get props => [this.context, this.colorIndex];

  @override
  String toString() => 'RegisterInitialEvent';
}

// class RegisterCreatedNoteEvent extends RegisterEvent {
//   final BuildContext context;
//   final int colorIndex;
//   final ElementNote notes;

//   const RegisterCreatedNoteEvent({this.context, this.colorIndex, this.notes});

//   @override
//   List<Object> get props => [this.context, this.colorIndex, this.notes];

//   @override
//   String toString() => 'RegisterCreatedNoteEvent';
// }

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  const RegisterEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'RegisterEmailChanged { email :$email }';
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  const RegisterPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'RegisterPasswordChanged { password: $password }';
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;

  const RegisterSubmitted({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'RegisterSubmitted { email: $email, password: $password }';
  }
}
