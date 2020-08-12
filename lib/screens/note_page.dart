import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_adding_note/adding_note_bloc.dart';
import 'package:note/bloc/bloc_note/bloc.dart';
import 'package:note/bloc/bloc_note/note_bloc.dart';
import 'package:note/model/element_note.dart';
import 'package:note/screens/add_note_page.dart';
import 'package:note/widgets/drawer.dart';
import 'package:note/widgets/modal_bottom_sheets.dart/modal_bottom_sheets.dart';
import 'package:note/widgets/route_anim/fade_route.dart';

class NotePage extends StatefulWidget {
  final FirebaseUser user;

  NotePage({this.user});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  NoteBloc bloc;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

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

  Widget _buildItem(ElementNote note, [int index]) {
    return ListTile(
      key: ValueKey<ElementNote>(note),
      title: Text(note.title),
      subtitle: Text(note.text),
    );
  }

  Widget buildLoaded(List<ElementNote> list) {
    return Scaffold(
        appBar: AppBar(title: Text("Title")),
        drawer: CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => ModalBottomSheets(context).buildIntermediateSheet(
            title: 'I\'m so excited to start this journey with you, Name!',
            firstSubTitle:
                'Let\'s get your great new habit rolling by\ncreating your first story together!',
            secSubTitle:
                'Get started by clicking the \"Add Story\" card,\nand I\'ll guide you through the process.',
            isSubTitleBold: true,
            buttonText: 'Write on!',
            buttonFunc: () {},
          ),
        ),
        body: Stack(
          children: [
            AnimatedList(
              key: _listKey,
              initialItemCount: list.length,
              itemBuilder:
                  (BuildContext context, int index, Animation animation) {
                return FadeTransition(
                  opacity: animation,
                  child: _buildItem(list[index]),
                );
              },
            ),
          ],
        ));

    /*ListView.builder(
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
              ));*/
    // },
    // ),
    // );
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
