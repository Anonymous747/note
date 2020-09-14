import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_account_creation/bloc.dart';
import 'package:note/widgets/modal_bottom_sheets.dart/modal_bottom_sheets.dart';
import 'package:note/widgets/modal_bottom_sheets.dart/registration_bottom_sheet.dart';

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
          Navigator.of(event.context).pop(false);
          print('ok');
          preRegistration(event.context, event.colorIndex);
        },
        colorIndex: event.colorIndex,
        height: MediaQuery.of(event.context).size.height * 0.45,
      );
      print('event');
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
    } else if (event is AccountContinueEvent) {
      await Future.delayed(Duration(seconds: 1));
      ModalBottomSheets(event.context).buildIntermediateSheet(
        title: '1',
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

  void preRegistration(BuildContext context, int colorIndex) {
    ModalBottomSheets(context).buildIntermediateSheet(
      title: 'But wait, there\'s more!',
      firstSubTitle:
          'I can give you new personal questions every day to help you reflect on your life.',
      secSubTitle:
          'I\'ll also be able to show you trends and statisic from your journal on how you\'ve been progressing!',
      isSubTitleBold: true,
      buttonText: 'Sound Awesome!',
      buttonFunc: () {
        Navigator.of(context).pop(false);
        registration(context, colorIndex);
      },
      colorIndex: colorIndex,
      height: MediaQuery.of(context).size.height * 0.55,
    );
  }

  void registration(BuildContext context, int colorIndex) {
    RegistrationBottomSheets(context).buildRegistrationSheet();
  }
}
