import 'dart:async';

import 'package:fake_dona_app/blocs/tab/tab.dart';
import 'package:fake_dona_app/models/models.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc(super.initialState);

  //TabBloc(): super();

  AppTab get initialState => AppTab.todos;

  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}