part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class AppAddNoteTypeWithDeadLine extends AppEvent {
  final String message;
  final String date;
  final TypeNoteCard type;

  AppAddNoteTypeWithDeadLine(
      {@required this.message, @required this.date, @required this.type});
}

class AppAddNoteTypeImportant extends AppEvent {
  final String message;
  final String date;
  final TypeNoteCard type;

  AppAddNoteTypeImportant(
      {@required this.message, @required this.date, @required this.type});
}

class AppAddNoteTypeNoDeadline extends AppEvent {
  final String message;
  final String date;
  final TypeNoteCard type;

  AppAddNoteTypeNoDeadline(
      {@required this.message, @required this.date, @required this.type});
}

class AppAddNoteTypeLongTerm extends AppEvent {
  final String message;
  final String date;
  final TypeNoteCard type;

  AppAddNoteTypeLongTerm(
      {@required this.message, @required this.date, @required this.type});
}

class AppNoteLoaded extends AppEvent {}

class AppDeleteNote extends AppEvent {
  final int cardNumber;
  final int index;

  AppDeleteNote(this.cardNumber, this.index);
}
