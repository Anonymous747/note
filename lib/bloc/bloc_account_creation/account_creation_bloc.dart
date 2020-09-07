import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:note/bloc/bloc_account_creation/bloc.dart';
import 'package:note/model/element_note.dart';
import 'package:note/widgets/modal_bottom_sheets.dart/modal_bottom_sheets.dart';

class AccountCreationBloc
    extends Bloc<AccountCreationEvent, AccountCreationState> {
  AccountCreationBloc() : super(AccountCreationInitial());

  @override
  Stream<AccountCreationState> mapEventToState(
    AccountCreationEvent event,
  ) async* {
    if (event is AccountCreationInitialEvent) {
      yield AccountCreationGreeting();
    } else if (event is AccountNoteCreatedEvent) {
      yield AccountNoteCreatedState(note: event.note);
    } else if (event is AccountRegistrationEvent) {
      yield AccountCreationSuccess();
    }
  }
}
