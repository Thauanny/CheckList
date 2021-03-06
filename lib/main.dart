import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app_provider.dart';
import 'app/configs/shared_preferences_config.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.purple[50]));
  runApp(
    MyApp(),
  );
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
      home: BlocProvider<SharedPreferencesConfig>(
        create: (context) => SharedPreferencesConfig(),
        child: AppProvider(),
      ),
    );
  }
}
