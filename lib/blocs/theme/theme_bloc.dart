
import 'package:fake_dona_app/blocs/theme/theme.dart';
import 'package:fake_dona_app/models/models.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeTab> {
  

  ThemeBloc(super.initialState) {// this is now used in place of mapEventToState and initialState
    on<LightTab>((event, emit) => emit(event.tab));
    on<DarkTab>((event, emit) => emit(event.tab));
    on<BlackTab>((event, emit) => emit(event.tab));
    on<AutoTab>((event, emit) => emit(event.tab));
  }

  //TabBloc(): super();

  //ThemeTab get initialState => ThemeTab.light;

  // Stream<ThemeTab> mapEventToState(ThemeEvent event) async* {
  //   if (event is LightTab) {
  //     yield event.tab;
  //   } else if (event is DarkTab) {
  //     yield event.tab;
  //   } else if (event is BlackTab) {
  //     yield event.tab;
  //   } else if (event is AutoTab) {
  //     yield event.tab;
  //   }
  // }
}
