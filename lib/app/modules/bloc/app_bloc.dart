import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checklist/app/modules/models/note_model.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());

  List<Note> noteListWithDeadline = [];
  List<Note> noteLisimportant = [];
  List<Note> noteListNoDeadline = [];
  List<Note> noteListlongTerm = [];

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppAddNoteTypeWithDeadLine) {
      noteListWithDeadline.add(
          new Note(message: event.message, date: event.date, type: event.type));
      yield AppNoteRegistred();
    } else if (event is AppAddNoteTypeImportant) {
      noteLisimportant.add(
          new Note(message: event.message, date: event.date, type: event.type));
      yield AppNoteRegistred();
    } else if (event is AppAddNoteTypeNoDeadline) {
      noteListNoDeadline.add(
          new Note(message: event.message, date: event.date, type: event.type));
      yield AppNoteRegistred();
    } else if (event is AppAddNoteTypeLongTerm) {
      noteListlongTerm.add(
          new Note(message: event.message, date: event.date, type: event.type));
      yield AppNoteRegistred();
    }
  }
}
