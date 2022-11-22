import 'package:equatable/equatable.dart';
import 'package:fake_dona_app/models/models.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class LightTab extends ThemeEvent {
  final ThemeTab tab;

  const LightTab(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'LightTab { tab: $tab }';
}

class DarkTab extends ThemeEvent {
  final ThemeTab tab;

  const DarkTab(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'DarkTab { tab: $tab }';
}

class BlackTab extends ThemeEvent {
  final ThemeTab tab;

  const BlackTab(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'BlackTab { tab: $tab }';
}

class AutoTab extends ThemeEvent {
  final ThemeTab tab;

  const AutoTab(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'AutoTab { tab: $tab }';
}