import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CreationEvent extends Equatable {
  const CreationEvent();

  @override
  List<Object> get props => [];
}

class CreationStart {}

class CreationPercentFunChanged extends CreationEvent {
  final int percentFun;

  CreationPercentFunChanged({this.percentFun});

  @override
  List<Object> get props => [this.percentFun];

  @override
  String toString() => 'CreationPercentFunChanged ${this.percentFun}';
}

class CreationIconPreferencesChanged extends CreationEvent {
  final int iconPreferences;

  CreationIconPreferencesChanged({this.iconPreferences});

  @override
  List<Object> get props => [this.iconPreferences];

  @override
  String toString() => 'CreationIconPreferencesChanged ${this.iconPreferences}';
}

class CreationHappenedChanged extends CreationEvent {
  final String happened;

  CreationHappenedChanged({this.happened});

  @override
  List<Object> get props => [this.happened];

  @override
  String toString() => 'CreationHappenedChanged ${this.happened}';
}

class CreationemojiChanged extends CreationEvent {
  final int emoji;

  CreationemojiChanged({this.emoji});

  @override
  List<Object> get props => [this.emoji];

  @override
  String toString() => 'CreationemojiChanged ${this.emoji}';
}

class CreationRandomQuestionChanged extends CreationEvent {
  final String randomQuestion;
  final String answer;

  CreationRandomQuestionChanged({this.randomQuestion, this.answer});

  @override
  List<Object> get props => [this.randomQuestion, this.answer];

  @override
  String toString() =>
      'CreationRandomQuestionChanged question - ${this.randomQuestion} && answer - ${this.answer}';
}

class CreationSaveStory extends CreationEvent {
  final String title;
  final BuildContext context;

  CreationSaveStory({this.title, this.context});

  @override
  List<Object> get props => [this.title, this.context];

  @override
  String toString() => 'CreationSaveStory ${this.title}';
}

class CreationSuccesEvent extends CreationEvent {
  @override
  String toString() => 'CreationSucces';
}
