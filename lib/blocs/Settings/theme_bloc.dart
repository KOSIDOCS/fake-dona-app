import 'package:fake_dona_app/blocs/Settings/theme_event.dart';
import 'package:fake_dona_app/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeTab> {
  

  ThemeBloc(super.initialState) {// this is now used in place of mapEventToState and initialState
    on<LightTab>((event, emit) => emit(event.tab));
    on<DarkTab>((event, emit) => emit(event.tab));
    on<BlackTab>((event, emit) => emit(event.tab));
    on<AutoTab>((event, emit) => emit(event.tab));
  }
}