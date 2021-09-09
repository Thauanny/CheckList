import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/modules/home/home_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheckList',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeProvider(),
    );
  }
}
