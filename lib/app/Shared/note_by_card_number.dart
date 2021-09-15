import 'package:checklist/app/Shared/vertical_padding.dart';
import 'package:checklist/app/modules/bloc/app_bloc.dart';
import 'package:checklist/app/modules/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'color_by_card_number.dart';

Widget noteByCardNumber(BuildContext context, int cardNumber) {
  List<Note> cardNumberToListName;
  return BlocBuilder<AppBloc, AppState>(
    builder: (context, state) {
      final appBloc = BlocProvider.of<AppBloc>(context);
      switch (cardNumber) {
        case 1:
          cardNumberToListName =
              appBloc.sharedPreferencesConfig.noteListWithDeadline;
          break;
        case 2:
          cardNumberToListName =
              appBloc.sharedPreferencesConfig.noteLisimportant;
          break;
        case 3:
          cardNumberToListName =
              appBloc.sharedPreferencesConfig.noteListNoDeadline;
          break;
        default:
          cardNumberToListName =
              appBloc.sharedPreferencesConfig.noteListlongTerm;
          break;
      }

      return cardNumberToListName.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height / 2).toDouble(),
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.6,
                              height: 80,
                              child: Card(
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Text(
                                            cardNumberToListName[index]
                                                    .message ??
                                                '',
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                color: colorByCardNumber(
                                                    cardNumber)),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _showMyDialog(context, appBloc,
                                                index, cardNumber);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color:
                                                colorByCardNumber(cardNumber),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Container(
                                height: 50,
                                child: Card(
                                  child: Center(
                                    child: Text(
                                      cardNumberToListName[index].date,
                                      style: TextStyle(
                                        color: colorByCardNumber(cardNumber),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    separatorBuilder: (_, __) => VerticalPadding(5),
                    itemCount: cardNumberToListName.length),
              ),
            )
          : Text(
              'Adicione notas!',
              style:
                  TextStyle(color: colorByCardNumber(cardNumber), fontSize: 18),
            );
    },
  );
}

Future<void> _showMyDialog(
    BuildContext context, AppBloc appBloc, int index, int cardNumber) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Remover Nota',
            style: TextStyle(
              color: colorByCardNumber(cardNumber),
            )),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Voce tem certeza que deseja remover essa nota?',
                  style: TextStyle(
                    color: colorByCardNumber(cardNumber),
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar',
                style: TextStyle(
                  color: colorByCardNumber(cardNumber),
                )),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Sim',
                style: TextStyle(
                  color: colorByCardNumber(cardNumber),
                )),
            onPressed: () {
              appBloc.add(AppDeleteNote(cardNumber, index));

              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
