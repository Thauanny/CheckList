import 'dart:ui';

import 'package:checklist/app/Shared/color_by_card_number.dart';

import 'package:checklist/app/Shared/note_by_card_number.dart';
import 'package:checklist/app/Shared/vertical_padding.dart';
import 'package:checklist/app/configs/shared_preferences_config.dart';
import 'package:checklist/app/modules/bloc/app_bloc.dart';
import 'package:checklist/app/modules/register_note/register_note_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int keyAddNoteFloatingBtn = 0;
  AppBloc appBloc;

  @override
  Widget build(BuildContext context) {
    appBloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      body: ListView(
        children: [
          VerticalPadding(20),
          Center(
            child: Text(
              'CheckList',
              style: TextStyle(
                  color: Colors.blue[400],
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          VerticalPadding(20),
          viewAreaTasks(
              context: context,
              color: Colors.purpleAccent[100].withOpacity(0.5),
              title: 'Com prazo',
              subtitle: 'Coisas a serem compridas dentro do prazo',
              cardNumber: 1),
          VerticalPadding(20),
          viewAreaTasks(
              context: context,
              color: Colors.yellow[200],
              title: 'Importante',
              subtitle: 'Coisas sem prazo, mas que sao importantes',
              cardNumber: 2),
          VerticalPadding(20),
          viewAreaTasks(
              context: context,
              color: Colors.green[200],
              title: 'Sem Prazo',
              subtitle: 'Coisas sem um prazo defenido ',
              cardNumber: 3),
          VerticalPadding(20),
          viewAreaTasks(
              context: context,
              color: Colors.blue[200],
              title: 'Longo Prazo',
              subtitle: '',
              cardNumber: 4),
          VerticalPadding(20),
        ],
      ),
    );
  }

  Widget viewAreaTasks({
    BuildContext context,
    Color color,
    String title,
    String subtitle,
    int cardNumber,
  }) =>
      Center(
        child: Container(
          color: color,
          width: MediaQuery.of(context).size.width - 40,
          height: MediaQuery.of(context).size.height - 150,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 20,
                        color: colorByCardNumber(cardNumber),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    subtitle,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        fontSize: 15,
                        color: colorByCardNumber(cardNumber),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: BlocBuilder<SharedPreferencesConfig, AppState>(
                  builder: (context, state) {
                    return noteByCardNumber(context, cardNumber);
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FloatingActionButton(
                    heroTag: '${keyAddNoteFloatingBtn++}',
                    backgroundColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegisterNoteProvider(
                              cardNumber: cardNumber, appBloc: appBloc),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.add,
                      color: colorByCardNumber(cardNumber),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
