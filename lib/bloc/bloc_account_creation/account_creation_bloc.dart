import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_account_creation/bloc.dart';
import 'package:note/widgets/modal_bottom_sheets.dart/modal_bottom_sheets.dart';

class AccountCreationBloc
    extends Bloc<AccountCreationEvent, AccountCreationState> {
  AccountCreationBloc() : super(AccountCreationInitial());

  @override
  Stream<AccountCreationState> mapEventToState(
    AccountCreationEvent event,
  ) async* {
    if (event is AccountCreationInitialEvent) {
      await Future.delayed(Duration(seconds: 1));
      ModalBottomSheets(event.context).buildIntermediateSheet(
        title: 'I\'m so excited to start this journey with you, Name!',
        firstSubTitle:
            'Let\'s get your great new habit rolling by\ncreating your first story together!',
        secSubTitle:
            'Get started by clicking the \"Add Story\" card,\nand I\'ll guide you through the process.',
        isSubTitleBold: true,
        buttonText: 'Write on!',
        buttonFunc: () {
          Navigator.of(event.context).pop(false);
          print('ok');
        },
        colorIndex: event.colorIndex,
        height: MediaQuery.of(event.context).size.height * 0.55,
      );
      yield AccountCreationGreeting();
    } else if (event is AccountNoteCreatedEvent) {
      await Future.delayed(Duration(seconds: 1));
      ModalBottomSheets(event.context).buildIntermediateSheet(
        title: 'Awesome, first one in the books!',
        firstSubTitle:
            'Going forward, I\'ll also have othe questions to help you reflect.',
        isSubTitleBold: true,
        buttonText: 'Amazing!',
        buttonFunc: () {
          // await Future.delayed(Duration(seconds: 1));
          Navigator.of(event.context).pop(false);
          print('ok');
          ModalBottomSheets(event.context).buildIntermediateSheet(
            title: 'Awesome, first one in the books!',
            firstSubTitle:
                'Going forward, I\'ll also have othe questions to help you reflect.',
            isSubTitleBold: true,
            buttonText: 'Amazing!',
            buttonFunc: () {
              // BlocProvider.of<AccountCreationBloc>(event.context)
              //   ..add(AccountContinueEvent(
              //       context: event.context, colorIndex: event.colorIndex));
              Navigator.of(event.context).pop(false);
              // print('ok');
            },
            colorIndex: event.colorIndex,
            height: MediaQuery.of(event.context).size.height * 0.45,
          );
        },
        colorIndex: event.colorIndex,
        height: MediaQuery.of(event.context).size.height * 0.45,
      );
      yield AccountNoteCreatedState(note: event.note);
    } else if (event is AccountContinueEvent) {
      yield AccountContinueState();
      await Future.delayed(Duration(seconds: 1));
      ModalBottomSheets(event.context).buildIntermediateSheet(
        title: 'Awesome, first one in the books!',
        firstSubTitle:
            'Going forward, I\'ll also have othe questions to help you reflect.',
        isSubTitleBold: true,
        buttonText: 'Amazing!',
        buttonFunc: () {
          BlocProvider.of<AccountCreationBloc>(event.context)
            ..add(AccountContinueEvent(
                context: event.context, colorIndex: event.colorIndex));
          Navigator.of(event.context).pop(false);
          print('ok');
        },
        colorIndex: event.colorIndex,
        height: MediaQuery.of(event.context).size.height * 0.45,
      );
    } else if (event is AccountRegistrationEvent) {
      yield AccountCreationSuccess();
    }
  }
}
