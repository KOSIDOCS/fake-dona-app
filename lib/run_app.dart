import 'package:fake_dona_app/blocs/blocs.dart';
import 'package:fake_dona_app/core/theme_data.dart';
import 'package:fake_dona_app/models/models.dart';
import 'package:fake_dona_app/repository/todos_repository.dart';
import 'package:fake_dona_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void runBlocLibraryApp(TodosRepository repository) {
  // BlocSupervisor oversees Blocs and delegates to BlocDelegate.
  // We can set the BlocSupervisor's delegate to an instance of `SimpleBlocDelegate`.
  // This will allow us to handle all transitions and errors in SimpleBlocDelegate.
  Bloc.observer = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TodosBloc>(
          create: (context) {
            return TodosBloc(todosRepository: repository)..add(LoadTodos());
          },
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(ThemeTab.light),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeTab>(builder: (context, activeTab) {
      return MaterialApp(
        title: 'Fake Dona App',
        theme: getThemeData(selectedTab: activeTab),
        darkTheme: activeTab == ThemeTab.auto ? themeDark : null,
        themeMode: activeTab == ThemeTab.auto ? ThemeMode.system : null,
        //themeMode: ThemeMode.light,
        home: const MainScreen(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
