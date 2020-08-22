import 'package:flutter/material.dart';
import 'package:note/widgets/buttons/dialog_button.dart';

class AlertDialogs {
  BuildContext context;

  AlertDialogs(this.context);

  void forgotPressed() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Reset Password",
                    ),
                  ),
                  Text(
                    'Input yout account email below and we\'ll send you a link to recover your password.',
                    style: TextStyle(fontSize: 13, color: Colors.black38),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          helperText: 'your email'.toUpperCase()),
                    ),
                  )
                ],
              ),
              content: Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: DialogButton(
                        child: Icon(
                          Icons.clear,
                          color: Colors.black54,
                        ),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: DialogButton(
                        color: Colors.white,
                        child: Icon(
                          Icons.check,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  Future<bool> onBackPressed() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text("Are you sure?".toUpperCase(),
                  style: TextStyle(color: Colors.red[300])),
            ),
            Text(
              "Are you certain that you want to close Mirroring?",
              style: TextStyle(fontSize: 15, color: Colors.black45),
              textAlign: TextAlign.center,
            )
          ],
        ),
        content: Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            children: <Widget>[
              Expanded(
                child: DialogButton(
                  color: Colors.white,
                  child: Icon(Icons.clear),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ),
              Expanded(
                child: DialogButton(
                  color: Colors.white,
                  child: Icon(Icons.check),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return true;
  }

  Future<bool> onBackPressedInCreatingNote() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text("Are you sure?".toUpperCase(),
                  style: TextStyle(color: Colors.red[300])),
            ),
            Text(
              "This story will not be saved and you cannot get it back!",
              style: TextStyle(fontSize: 15, color: Colors.black45),
              textAlign: TextAlign.center,
            )
          ],
        ),
        content: Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            children: <Widget>[
              Expanded(
                child: DialogButton(
                  color: Colors.white,
                  child: Icon(Icons.clear),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ),
              Expanded(
                child: DialogButton(
                    color: Colors.white,
                    child: Icon(Icons.check),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
    return true;
  }
}
