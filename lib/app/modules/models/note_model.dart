import 'package:flutter/material.dart';
import 'dart:convert';

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

  static Map<String, dynamic> toMap(Note note, String type) =>
      {'message': note.message, 'date': note.date, 'type': type};

  factory Note.fromJson(Map<String, dynamic> jsonData) {
    return Note(
      date: jsonData['date'],
      message: jsonData['message'],
      type: jsonData['type'] == 'TypeNoteCard.withDeadline'
          ? TypeNoteCard.withDeadline
          : TypeNoteCard.important,
    );
  }

  static String encode(List<Note> note) => json.encode(
        note
            .map<Map<String, dynamic>>(
                (note) => Note.toMap(note, note.type.toString()))
            .toList(),
      );

  static List<Note> decode(String note) {
    try {
      return (json.decode(note) as List<dynamic>)
          .map<Note>((item) => Note.fromJson(item))
          .toList();
    } catch (e) {
      return null;
    }
  }
}
