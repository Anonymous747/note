import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_adding_note/adding_note_bloc.dart';
import 'package:note/bloc/bloc_adding_note/bloc.dart';
import 'package:note/bloc/bloc_note/bloc.dart';
import 'package:note/screens/note_page.dart';

class AddingNotePage extends StatefulWidget {
  @override
  _AddingNotePageState createState() => _AddingNotePageState();
}

class _AddingNotePageState extends State<AddingNotePage> {
  AddingNoteBloc bloc;
  TextEditingController titleController = new TextEditingController();
  TextEditingController textController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AddingNoteBloc>(context);
    bloc.add(AddingNoteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adding new note"),
        centerTitle: true,
      ),
      body: BlocListener<AddingNoteBloc, AddingNoteState>(
        listener: (context, state) {
          if (state is AddingNoteFailure) {
            return buildError(state.message);
          }
        },
        child: BlocBuilder<AddingNoteBloc, AddingNoteState>(
          builder: (context, state) {
            if (state is AddingNoteInitial) {
              return Container();
            } else if (state is AddingNoteLoading) {
              return buidLoading();
            } else if (state is AddingNoteLoaded) {
              return buildFields();
            } else if (state is AddingNoteFailure) {
              return buildError(state.message);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildFields() {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(249, 161, 154, 1),
        body: Container(
          child: Column(
            children: <Widget>[
              Text(
                "Fill the fields to create a note:",
                style: TextStyle(letterSpacing: 2, fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.only(),
                child: Column(
                  children: <Widget>[
                    new TextField(
                      decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(
                            fontStyle: FontStyle.normal, fontSize: 15),
                        border: InputBorder.none,
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
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    new TextField(
                      expands: false,
                      decoration: InputDecoration(
                        hintText: "Text",
                        hintStyle: TextStyle(
                            fontStyle: FontStyle.normal, fontSize: 15),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          left: 16.0,
                          top: 15.0,
                          right: 16.0,
                          bottom: 5.0,
                        ),
                      ),
                      controller: textController,
                      minLines: 3,
                      maxLines: 10,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.note_add),
            onPressed: () async {
              // widget.repository
              //     .makeNote(titleController.text, textController.text);
              // FirebaseUser user = await FirebaseAuth.instance.currentUser();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return BlocProvider<NoteBloc>.value(
                    value: NoteBloc(),
                    child: NotePage(),
                  );
                }),
              );
            }));
  }

  Widget buidLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildError(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          error,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
