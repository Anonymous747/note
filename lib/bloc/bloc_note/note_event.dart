import 'package:equatable/equatable.dart';

abstract class NoteEvent extends Equatable {}

class FetchNotes extends NoteEvent {
  @override
  List<Object> get props => [];
}
