import 'package:flutter/material.dart';
import 'package:note/widgets/buttons/dialog_button.dart';
import 'package:note/widgets/logo_widget.dart';
import 'package:note/utils/consts.dart';

class ModalBottomSheets {
  BuildContext _context;

  ModalBottomSheets(this._context);
  Future<void> buildIntermediateSheet({
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
    showModalBottomSheet(
        enableDrag: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black87,
        isDismissible: false,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            side: BorderSide(width: 0, color: Colors.black45.withOpacity(0.1))),
        context: _context,
        builder: (context) {
          return Container(
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
                      padding: EdgeInsets.only(top: 80, right: 25, left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            title ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            firstSubTitle ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            secSubTitle ?? '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
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
          );
        });
  }
}
