import 'package:equatable/equatable.dart';
import 'package:note/bloc/bloc_authentication/bloc.dart';
import 'package:note/repository/user_repository.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String name;
  final UserRepository repository;

  const AuthenticationSuccess({this.name, this.repository});

  @override
  List<Object> get props => [name, repository];

  @override
  String toString() => 'AuthenticationSuccess {name: $name}';
}

class AuthenticationFailure extends AuthenticationState {}
