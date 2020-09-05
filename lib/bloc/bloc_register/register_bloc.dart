import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:note/bloc/bloc_register/bloc.dart';
import 'package:note/repository/user_repository.dart';
import 'package:note/widgets/modal_bottom_sheets.dart/modal_bottom_sheets.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository _userRepository;

  RegisterBloc() : super(RegisterState.initial()) {
    _userRepository = UserRepository();
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterInitialEvent) {
      yield* _mapRegisterInitialToState(event.context, event.colorIndex);
    } else if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangedToState(event.email);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangedToState(event.password);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event.email, event.password);
    }
  }

  Stream<RegisterState> _mapRegisterInitialToState(
      BuildContext context, int colorIndex) async* {
    await Future.delayed(Duration(milliseconds: 1000));
    ModalBottomSheets(context).buildIntermediateSheet(
      title: 'I\'m so excited to start this journey with you, Name!',
      firstSubTitle:
          'Let\'s get your great new habit rolling by\ncreating your first story together!',
      secSubTitle:
          'Get started by clicking the \"Add Story\" card,\nand I\'ll guide you through the process.',
      isSubTitleBold: true,
      buttonText: 'Write on!',
      buttonFunc: () {
        Navigator.of(context).pop(false);
        print('ok');
      },
      colorIndex: colorIndex,
    );
  }

  Stream<RegisterState> _mapRegisterEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: true //Validators.isValidEmail(email),
        );
  }

  Stream<RegisterState> _mapRegisterPasswordChangedToState(
      String password) async* {
    yield state.update(
        isPasswordValid: true //Validators.isValidPassword(password),
        );
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
    String email,
    String password,
  ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
        email: email,
        password: password,
      );
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
