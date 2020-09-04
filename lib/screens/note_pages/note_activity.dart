import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_note/bloc.dart';
import 'package:note/model/element_note.dart';
import 'package:note/screens/note_pages/note_exports.dart';
import 'package:note/widgets/drawer.dart';

class NoteActivity extends StatefulWidget {
  final int colorIndex;

  NoteActivity({this.colorIndex = 0});
  @override
  _NoteActivityState createState() => _NoteActivityState();
}

class _NoteActivityState extends State<NoteActivity> {
  int _currentPage;
  // List<ElementNote> notes;
  List<Widget> pages;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    // notes = List<ElementNote>();

    pages = [
      NotePage(),
      StatsPage(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        colorIndex: widget.colorIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          selectedFontSize: 10,
          showUnselectedLabels: false,
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black),
          unselectedItemColor: Colors.black26,
          iconSize: 30,
          currentIndex: _currentPage,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.edit), title: Text('●')),
            BottomNavigationBarItem(
                icon: Icon(Icons.assessment), title: Text('●')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), title: Text('●')),
          ],
          onTap: (index) {
            setState(() {
              _currentPage = index;
            });
          }),
      body: BlocProvider<NoteBloc>(
        create: (context) => NoteBloc()..add(FetchNotes()),
        child: BlocListener<NoteBloc, NoteState>(
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
                return buildLoaded(state.element, state.colorIndex);
              } else if (state is NoteErrorState) {
                return buildError(state.message);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buidLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildLoaded(List<ElementNote> list, int colorIndex) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    // this.notes = list;

    if (_currentPage == 0) {
      return NotePage(
        notes: list,
        initialIndex: colorIndex,
      );
    }

    return pages[_currentPage];
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
