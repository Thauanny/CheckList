import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checklist/app/configs/shared_preferences_config.dart';
import 'package:checklist/app/modules/models/note_model.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({@required this.sharedPreferencesConfig}) : super(AppInitial());
  final SharedPreferencesConfig sharedPreferencesConfig;
  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppAddNoteTypeWithDeadLine) {
      sharedPreferencesConfig.noteListWithDeadline.add(
          Note(message: event.message, date: event.date, type: event.type));
      sharedPreferencesConfig.setNotes(event.type);
      yield AppNoteRegistred();
    } else if (event is AppAddNoteTypeImportant) {
      sharedPreferencesConfig.noteLisimportant.add(
          Note(message: event.message, date: event.date, type: event.type));
      sharedPreferencesConfig.setNotes(event.type);
      yield AppNoteRegistred();
    } else if (event is AppAddNoteTypeNoDeadline) {
      sharedPreferencesConfig.noteListNoDeadline.add(
          Note(message: event.message, date: event.date, type: event.type));
      sharedPreferencesConfig.setNotes(event.type);
      yield AppNoteRegistred();
    } else if (event is AppAddNoteTypeLongTerm) {
      sharedPreferencesConfig.noteListlongTerm.add(
          Note(message: event.message, date: event.date, type: event.type));
      sharedPreferencesConfig.setNotes(event.type);
      yield AppNoteRegistred();
    } else if (event is AppNoteLoaded) {
      yield AppAddNoteLoaded();
    }
  }
}
