import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_account_creation/account_creation_bloc.dart';
import 'package:note/bloc/bloc_account_creation/bloc.dart';
import 'package:note/bloc/bloc_register/bloc.dart';
import 'package:note/utils/consts.dart';
import 'package:note/widgets/buttons/dialog_button.dart';
import 'package:note/widgets/logo_widget.dart';

class RegistrationBottomSheets {
  BuildContext _context;

  RegistrationBottomSheets(this._context);
  Future<void> buildRegistrationSheet({
    String title,
    String firstSubTitle,
    String secSubTitle,
    bool isSubTitleBold,
    String buttonText,
    int colorIndex,
    Function buttonFunc,
    double height,
  }) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // int colorIndex = sharedPreferences.get('color');
    TextEditingController controoller = TextEditingController();
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black54,
        isDismissible: false,
        // clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            side: BorderSide(width: 0, color: Colors.black45.withOpacity(0.1))),
        context: _context,
        builder: (context) {
          return BlocProvider(
              create: (context) => RegisterBloc(),
              child: BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) => Container(
                  height: height,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50, right: 5, left: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 80, right: 30, left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  title ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: controoller,
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                          fontSize: 25, color: Colors.black38)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: controoller,
                                  decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          fontSize: 25, color: Colors.black38)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: controoller,
                                  decoration: InputDecoration(
                                    hintText: 'Confirm password',
                                    hintStyle: TextStyle(
                                        fontSize: 25, color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 50, horizontal: 30),
                            child: DialogButton(
                              child: Text(
                                (buttonText ?? 'Continue').toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                              gradient: listColor[colorIndex ?? 1],
                              onPressed: buttonFunc,
                              radius: BorderRadius.circular(30),
                              height: MediaQuery.of(context).size.height * 0.08,
                            )),
                      ),
                      LogoWidget(),
                    ],
                  ),
                ),
              ));
        });
  }
}
