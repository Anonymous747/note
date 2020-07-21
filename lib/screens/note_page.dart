import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/bloc/bloc_note/bloc.dart';
import 'package:note/bloc/bloc_note/note_bloc.dart';
import 'package:note/model/element_note.dart';
import 'package:note/repository/user_repository.dart';

// class NotePage extends StatefulWidget {
//   @override
//   _NotePageState createState() => _NotePageState();
// }

// class _NotePageState extends State<NotePage> {
//   NoteBloc bloc;

//   @override
//   void initState() {
//     super.initState();
//     bloc = BlocProvider.of<NoteBloc>(context);
//     bloc.add(FetchNotes());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocListener<NoteBloc, NoteState>(
//         listener: (context, state) {
//           if (state is NoteErrorState) {
//             buildError(state.message);
//           }
//         },
//         child: BlocBuilder<NoteBloc, NoteState>(
//           builder: (context, state) {
//             if (state is NoteInitState) {
//               return Container();
//             } else if (state is NoteLoadingState) {
//               buidLoading();
//             } else if (state is NoteLoadedState) {
//               buildLoaded(state.element);
//             } else if (state is NoteErrorState) {
//               buildError(state.message);
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }

//   Widget buidLoading() {
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }

//   Widget buildLoaded(List<ElementNote> list) {
//     return ListView.builder(
//       itemCount: list.length,
//       itemBuilder: (context, index) {
//         return Padding(
//             padding: const EdgeInsets.all(8),
//             child: InkWell(
//               child: ListTile(
//                 title: Text(list[index].title),
//                 subtitle: Text(list[index].text),
//                 onTap: () {},
//               ),
//             ));
//       },
//     );
//   }

//   Widget buildError(String message) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Text(
//           message,
//           style: TextStyle(color: Colors.red),
//         ),
//       ),
//     );
//   }
// }
