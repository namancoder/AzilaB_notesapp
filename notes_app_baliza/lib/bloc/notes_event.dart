part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class AddEvent extends NotesEvent {
  String? title;
  String? description;
  String? dateTime = DateTime.now().toString();
  AddEvent({this.title, this.description, this.dateTime});
}

class UpdateEvent extends NotesEvent {
  String? title;
  String? description;
  String? dateTime = DateTime.now().toString();
  UpdateEvent({this.title, this.description, this.dateTime});
}

class GetAllEvent extends NotesEvent {}

class DeleteEvent extends NotesEvent {}
