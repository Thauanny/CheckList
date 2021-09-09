import 'package:checklist/app/modules/bloc/app_bloc.dart';
import 'package:checklist/app/modules/register_note/register_note_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterNoteProvider extends StatelessWidget {
  RegisterNoteProvider(
      {Key key, @required this.appBloc, @required this.cardNumber})
      : super(key: key);
  final AppBloc appBloc;
  final int cardNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: appBloc,
      child: RegisterNotePage(
        cardNumber: cardNumber,
        appBloc: appBloc,
      ),
    );
  }
}
