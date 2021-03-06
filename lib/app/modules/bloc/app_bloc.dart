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
    } else if (event is AppDeleteNote) {
      try {
        switch (event.cardNumber) {
          case 1:
            sharedPreferencesConfig.noteListWithDeadline.removeAt(event.index);
            sharedPreferencesConfig.setNotes(TypeNoteCard.withDeadline);

            break;
          case 2:
            sharedPreferencesConfig.noteLisimportant.removeAt(event.index);
            sharedPreferencesConfig.setNotes(TypeNoteCard.important);
            break;
          case 3:
            sharedPreferencesConfig.noteListNoDeadline.removeAt(event.index);
            sharedPreferencesConfig.setNotes(TypeNoteCard.noDeadline);
            break;
          default:
            sharedPreferencesConfig.noteListlongTerm.removeAt(event.index);
            sharedPreferencesConfig.setNotes(TypeNoteCard.longTerm);
            break;
        }
        yield AppRemoveSucess();
      } catch (e) {
        yield AppRemoveError();
      }
    }
  }
}
