import 'package:equatable/equatable.dart';

abstract class SplashScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class SplashScreenInitial extends SplashScreenState {}

class SplashScreenSucces extends SplashScreenState {}

class SplashScreenFailure extends SplashScreenState {
  final String message;

  SplashScreenFailure({this.message});

  @override
  List<Object> get props => [this.message];
}
