import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String name;

  const AuthenticationSuccess(this.name);

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'AuthenticationSuccess {name: $name}';
}

class AuthenticationFailure extends AuthenticationState {}
