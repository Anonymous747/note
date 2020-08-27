import 'package:equatable/equatable.dart';

abstract class CreationState extends Equatable {
  const CreationState();

  @override
  List<Object> get props => [];
}

class CreationInitial extends CreationState {}

class CreationSuccess extends CreationState {}
