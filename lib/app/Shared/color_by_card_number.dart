import 'package:flutter/material.dart';

Color colorByCardNumber(int cardNumber) => cardNumber == 1
    ? Colors.purple[400]
    : cardNumber == 2
        ? Colors.yellow[700]
        : cardNumber == 3
            ? Colors.green[400]
            : Colors.blue[400];
