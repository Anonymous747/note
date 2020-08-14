import 'package:equatable/equatable.dart';

abstract class BeginingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BeginingStartEvent extends BeginingEvent {}
