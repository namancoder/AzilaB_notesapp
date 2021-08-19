part of 'notes_bloc.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}


class LoadingState extends NotesState {}

class AddState extends NotesState {}


class GetState extends NotesState {

  List<NotesModel> ?userNotes;
  GetState({this.userNotes});
}