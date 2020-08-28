import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:note/bloc/bloc_creation/bloc.dart';
import 'package:note/model/element_note.dart';
import 'package:note/repository/remote_data_repository.dart';

class CreationBloc extends Bloc<CreationEvent, CreationState> {
  ElementNote note;
  RemDataRepImpl _dataRepository;
  CreationBloc() : super(CreationInitial()) {
    note = ElementNote();
    _dataRepository = RemDataRepImpl();
  }

  @override
  Stream<CreationState> mapEventToState(
    CreationEvent event,
  ) async* {
    if (event is CreationPercentFunChanged) {
      note.percentFun = event.percentFun;
    } else if (event is CreationIconPreferencesChanged) {
      note.iconPreferences = event.iconPreferences;
    } else if (event is CreationHappenedChanged) {
      note.happened = event.happened;
    } else if (event is CreationFeelingIconChanged) {
      note.feelingIcon = event.feelingIcon;
    } else if (event is CreationRandomQuestionChanged) {
      note.randomQuestion = event.randomQuestion;
      note.answer = event.answer;
    } else if (event is CreationSaveStory) {
      note.title = event.title;

      try {
        await _dataRepository.makeNote(
          date: DateTime.now(),
          title: note.title,
          happened: note.happened,
          percentFun: note.percentFun,
          iconPreferences: note.iconPreferences,
          feelingIcon: note.feelingIcon,
          randomQuestion: note.randomQuestion,
          answer: note.answer,
        );
      } on PlatformException catch (e) {
        print(e);
      }
    }
  }
}
