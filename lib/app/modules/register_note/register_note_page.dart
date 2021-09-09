import 'package:checklist/app/Shared/color_by_card_number.dart';
import 'package:checklist/app/Shared/vertical_padding.dart';
import 'package:checklist/app/modules/bloc/app_bloc.dart';
import 'package:checklist/app/modules/models/note_model.dart';
import 'package:flutter/material.dart';

class RegisterNotePage extends StatefulWidget {
  RegisterNotePage({@required this.cardNumber, Key key, @required this.appBloc})
      : super(key: key);
  final int cardNumber;
  final AppBloc appBloc;

  @override
  _RegisterNotePageState createState() =>
      _RegisterNotePageState(cardNumber, appBloc);
}

class _RegisterNotePageState extends State<RegisterNotePage> {
  final int cardNumber;
  final AppBloc appBloc;
  String choosenDate = ' - - ';
  String message;

  _RegisterNotePageState(this.cardNumber, this.appBloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            colorByCardNumber(cardNumber).withOpacity(0.8).withOpacity(0.8),
        centerTitle: true,
        title: Text('Registar lembrete'),
      ),
      body: ListView(
        children: [
          VerticalPadding(50),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Center(
              child: Text(
                'Escreva uma mensagem',
                overflow: TextOverflow.fade,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (value) {
                message = value;
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.5,
                      color: colorByCardNumber(cardNumber).withOpacity(0.8)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: colorByCardNumber(cardNumber).withOpacity(0.8),
                      width: 2.0),
                ),
                hintText: 'Mensagem',
                prefixIcon: Icon(
                  Icons.note,
                  size: 30,
                  color: colorByCardNumber(cardNumber).withOpacity(0.8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Center(
              child: Text(
                'Selecione uma data',
                overflow: TextOverflow.fade,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          VerticalPadding(20),
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: colorByCardNumber(cardNumber).withOpacity(0.8),
              ),
              onPressed: () {
                _selectDate(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Clique para escolher uma data'),
                  Icon(Icons.calendar_today),
                ],
              ),
            ),
          ),
          VerticalPadding(5),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Card(
                color: colorByCardNumber(cardNumber).withOpacity(0.8),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Data Escolhida:',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                        Text(
                          choosenDate,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          VerticalPadding(20),
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: colorByCardNumber(cardNumber).withOpacity(0.8),
              ),
              onPressed: () {
                switch (cardNumber) {
                  case 1:
                    appBloc.add(AppAddNoteTypeWithDeadLine(
                        message: message,
                        date: choosenDate,
                        type: TypeNoteCard.withDeadline));
                    Navigator.pop(context);
                    break;
                  case 2:
                    appBloc.add(AppAddNoteTypeImportant(
                        message: message,
                        date: choosenDate,
                        type: TypeNoteCard.important));
                    Navigator.pop(context);
                    break;
                  case 3:
                    appBloc.add(AppAddNoteTypeNoDeadline(
                        message: message,
                        date: choosenDate,
                        type: TypeNoteCard.noDeadline));
                    Navigator.pop(context);
                    break;

                  default:
                    appBloc.add(AppAddNoteTypeLongTerm(
                        message: message,
                        date: choosenDate,
                        type: TypeNoteCard.longTerm));
                    Navigator.pop(context);
                }
              },
              child: Text('Salvar'),
            ),
          )
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      builder: (_, __) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: colorByCardNumber(cardNumber).withOpacity(0.8),
              onPrimary: Colors.white,
              surface: colorByCardNumber(cardNumber).withOpacity(0.8),
              onSurface: Colors.black87,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: __,
        );
      },
      cancelText: 'Cancelar',
      confirmText: 'Salvar',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (selected != null) {
      setState(() {
        choosenDate = selected.toString().substring(0, 10);
      });
    }
  }
}
