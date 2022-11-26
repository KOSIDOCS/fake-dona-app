import 'package:fake_dona_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/Settings/theme.dart';

void changeTheme(String name, {required BuildContext context}) {
  final themeBloc = BlocProvider.of<ThemeBloc>(context);
  switch (name) {
    case 'light':
      themeBloc.add(LightTab(ThemeTab.values[0]));
      break;
    case 'dark':
      themeBloc.add(DarkTab(ThemeTab.values[1]));
      break;
    case 'black':
      themeBloc.add(BlackTab(ThemeTab.values[2]));
      break;
    case 'auto':
      themeBloc.add(AutoTab(ThemeTab.values[3]));
      break;
    default:
  }
}
