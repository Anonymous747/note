import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddingNotePage extends StatefulWidget {
  @override
  _AddingNotePageState createState() => _AddingNotePageState();
}

class _AddingNotePageState extends State<AddingNotePage> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController textController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
          inAsyncCall: false,
          child: new Stack(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          new TextFormField(
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.teal),
                              ),
                              labelText: "Title",
                              contentPadding: EdgeInsets.only(
                                left: 16.0,
                                top: 20.0,
                                right: 16.0,
                                bottom: 5.0,
                              ),
                            ),
                            controller: titleController,
                            autofocus: true,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                            ),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            maxLength: 20,
                          ),
                          new TextFormField(
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.teal),
                              ),
                              labelText: "Text",
                              contentPadding: EdgeInsets.only(
                                left: 16.0,
                                top: 20.0,
                                right: 16.0,
                                bottom: 5.0,
                              ),
                            ),
                            controller: textController,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                            ),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
