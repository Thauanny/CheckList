import 'package:flutter/material.dart';

enum TypeNoteCard {
  withDeadline,
  important,
  noDeadline,
  longTerm,
}

class Note {
  final String message;
  final String date;
  final TypeNoteCard type;

  Note({@required this.message, @required this.date, @required this.type});
}
