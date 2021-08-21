import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notes_app_baliza/data/notes_model.dart';
import 'package:notes_app_baliza/data/notes_repository.dart';
import 'package:intl/intl.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesRepository repo;

  NotesBloc(this.repo) : super(NotesInitial());

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetAllEvent) {
      yield LoadingState();
      var notes = await repo.getnotes();
      yield GetState(userNotes: notes);
    } else if (event is AddEvent) {
      await repo.addEmp(NotesModel(
          title: event.title,
          description: event.description,
          datetime: DateFormat("MMMM d, y, hh:mm  ").format(DateTime.now())));
      yield AddState();
    }
    else if (event is UpdateEvent){
      
    }
  }
}
