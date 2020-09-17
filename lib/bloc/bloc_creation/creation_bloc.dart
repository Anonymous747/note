import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_account_creation/account_creation_bloc.dart';
import 'package:note/bloc/bloc_account_creation/bloc.dart';
import 'package:note/bloc/bloc_creation/bloc.dart';
import 'package:note/bloc/bloc_register/bloc.dart';
import 'package:note/model/element_note.dart';
import 'package:note/repository/remote_data_repository.dart';

class CreationBloc extends Bloc<CreationEvent, CreationState> {
  ElementNote note;
  RemDataRepImpl _dataRepository;
  FirebaseUser currentUser;
  CreationBloc() : super(CreationInitial()) {
    note = ElementNote();
    _dataRepository = RemDataRepImpl();
    _userStatus();
  }

  void _userStatus() async {
    currentUser = await FirebaseAuth.instance.currentUser();
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
    } else if (event is CreationemojiChanged) {
      note.emoji = event.emoji;
    } else if (event is CreationRandomQuestionChanged) {
      note.randomQuestion = event.randomQuestion;
      note.answer = event.answer;
    } else if (event is CreationSaveStory) {
      note.title = event.title;

      try {
        if (currentUser != null) {
          await _dataRepository.makeNote(
            date: DateTime.now(),
            title: note.title,
            happened: note.happened,
            percentFun: note.percentFun,
            iconPreferences: note.iconPreferences,
            emoji: note.emoji,
            randomQuestion: note.randomQuestion,
            answer: note.answer,
          );
        } else if (currentUser == null) {
          note.date = DateTime.now();
          yield CreationSuccess(note: note);

          // BlocProvider.of<AccountCreationBloc>(event.context)
          //     .add(AccountNoteCreatedEvent(context: event.context, note: note));
        }
      } on PlatformException catch (e) {
        print(e);
      }
    } else if (event is CreationSuccesEvent) {
      yield CreationMoveToNote(note: note);
    }
  }
}
