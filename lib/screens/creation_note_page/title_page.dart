import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_account_creation/account_creation_bloc.dart';
import 'package:note/bloc/bloc_account_creation/bloc.dart';
import 'package:note/bloc/bloc_creation/bloc.dart';
import 'package:note/bloc/bloc_note/bloc.dart';
import 'package:note/bloc/bloc_register/bloc.dart';
import 'package:note/screens/note_pages/note_activity.dart';
import 'package:note/screens/registration_note_page.dart';
import 'package:note/widgets/custom_text_field.dart';
import 'package:note/widgets/flat_transparent_button.dart';
import 'package:note/widgets/raised_white_button.dart';
import 'package:note/widgets/texts/font_white_text.dart';

class TitlePage extends StatefulWidget {
  final Color textColor;
  final bool isAuthorized;
  final Function backFunction;
  final int colorIndex;

  TitlePage(
      {this.textColor,
      this.isAuthorized,
      this.backFunction,
      this.colorIndex = 0});

  @override
  _TitlePageState createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: _height * 0.3, right: 20, left: 20),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleWhiteText(
            text:
                'Marvelous job - another day, another story! What would be a good title for it?',
            align: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(top: _height * 0.2),
            child: CustomTextField(
              controller: titleController,
              hintText: 'Add title ...',
              helperText: 'story title',
            ),
          ),
          Positioned.fill(
            top: _height * 0.50,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedWhiteButton(
                    text: Text('Save story'.toUpperCase()),
                    height: 0.08 * _height,
                    textColor: widget.textColor,
                    onPressed: () {
                      BlocProvider.of<CreationBloc>(context).add(
                          CreationSaveStory(
                              title: titleController.text, context: context));
                      if (widget.isAuthorized) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) {
                          return BlocProvider<NoteBloc>.value(
                            value: NoteBloc(),
                            child: NoteActivity(
                              colorIndex: widget.colorIndex,
                            ),
                          );
                        }), ModalRoute.withName('np'));
                      }
                    }),
                FlatTransparentButton(
                  text: Text('Wait, i forgot something!'.toUpperCase()),
                  function: widget.backFunction,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
