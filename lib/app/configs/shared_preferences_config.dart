import 'package:checklist/app/modules/bloc/app_bloc.dart';
import 'package:checklist/app/modules/models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesConfig extends AppBloc {
  SharedPreferences _prefs;

  List<Note> noteListWithDeadline = [];
  List<Note> noteLisimportant = [];
  List<Note> noteListNoDeadline = [];
  List<Note> noteListlongTerm = [];

  appSettings() {
    _startSettings();
  }

  _startSettings() async {
    await _startSharedPreferences();
    await _readNotes();
  }

  Future<void> _startSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _readNotes() {
    final String encodedNoteListWithDeadline =
        _prefs.getString('noteListWithDeadline');
    noteListWithDeadline = Note.decode(encodedNoteListWithDeadline) ?? [];
    final String encodedNoteLisimportant = _prefs.getString('noteLisimportant');
    noteLisimportant = Note.decode(encodedNoteLisimportant) ?? [];
    final String encodedNoteListNoDeadline =
        _prefs.getString('noteListNoDeadline');
    noteListNoDeadline = Note.decode(encodedNoteListNoDeadline) ?? [];
    final String encodedNoteListlongTerm = _prefs.getString('noteListlongTerm');
    noteListlongTerm = Note.decode(encodedNoteListlongTerm) ?? [];
    add(AppNoteLoaded());
  }

  setNotes(TypeNoteCard type) async {
    switch (type) {
      case TypeNoteCard.withDeadline:
        await _prefs.setString(
            'noteListWithDeadline', Note.encode(noteListWithDeadline));
        break;
      case TypeNoteCard.important:
        await _prefs.setString(
            'noteLisimportant', Note.encode(noteLisimportant));
        break;
      case TypeNoteCard.noDeadline:
        await _prefs.setString(
            'noteListNoDeadline', Note.encode(noteListNoDeadline));
        break;
      case TypeNoteCard.longTerm:
        await _prefs.setString(
            'noteListlongTerm', Note.encode(noteListlongTerm));

        break;
      default:
        break;
    }

    await _readNotes();
  }
}
