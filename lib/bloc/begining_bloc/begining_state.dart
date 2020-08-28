import 'package:equatable/equatable.dart';

abstract class BeginingState extends Equatable {
  @override
  List<Object> get props => [];
}

class BeginingInitial extends BeginingState {}

class BeginingLoading extends BeginingState {
  @override
  String toString() => 'BeginingLoading';
}

class BeginingSucces extends BeginingState {
  final int colorIndex;

  BeginingSucces({this.colorIndex});

  @override
  List<Object> get props => [this.colorIndex];

  @override
  String toString() => 'BeginingSucces';
}

class BeginingSuccesButEnered extends BeginingState {
  final int colorIndex;

  BeginingSuccesButEnered({this.colorIndex});

  @override
  List<Object> get props => [this.colorIndex];

  @override
  String toString() => 'BeginingSucces';
}

class BeginingFailure extends BeginingState {
  final String message;

  BeginingFailure({this.message});

  @override
  List<Object> get props => [this.message];

  @override
  String toString() => 'BeginingFailure';
}
