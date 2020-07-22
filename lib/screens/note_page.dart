import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_note/bloc.dart';
import 'package:note/bloc/bloc_note/note_bloc.dart';
import 'package:note/main.dart';
import 'package:note/model/element_note.dart';

class NotePage extends StatefulWidget {
  final FirebaseUser user;

  NotePage({this.user});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  NoteBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<NoteBloc>(context);
    bloc.add(FetchNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is NoteErrorState) {
            buildError(state.message);
          }
        },
        child: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteInitState) {
              return Container();
            } else if (state is NoteLoadingState) {
              return buidLoading();
            } else if (state is NoteLoadedState) {
              return buildLoaded(state.element);
            } else if (state is NoteErrorState) {
              return buildError(state.message);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buidLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildLoaded(List<ElementNote> list) {
    return Scaffold(
      appBar: AppBar(title: Text("Title")),
      drawer: Drawer(
        child: Column(
          children: <Widget>[ListView()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('ap');
        },
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                child: ListTile(
                  title: Text(list[index].title),
                  subtitle: Text(list[index].text),
                  onTap: () {
                    Navigator.of(context).pushNamed('ap');
                  },
                ),
              ));
        },
      ),
    );
  }

  Widget buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
