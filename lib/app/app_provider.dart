import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'configs/shared_preferences_config.dart';
import 'modules/bloc/app_bloc.dart';
import 'modules/home/home_provider.dart';

class AppProvider extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    final sharedPreferencesConfig =
        BlocProvider.of<SharedPreferencesConfig>(context);
    sharedPreferencesConfig.appSettings();
    return BlocProvider<AppBloc>(
        create: (context) =>
            AppBloc(sharedPreferencesConfig: sharedPreferencesConfig),
        child: HomeProvider());
  }
}
