import 'package:fake_dona_app/blocs/blocs.dart';
import 'package:fake_dona_app/blocs/theme/theme.dart';
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
    // BlocProvider<TodosBloc>(
    //   create: (context) {
    //     return TodosBloc(todosRepository: repository)..add(LoadTodos());
    //   },
    //   child: const TodosApp(),
    // ),
    MultiBlocProvider(
      providers: [
        BlocProvider<TodosBloc>(
          create: (context) {
            return TodosBloc(todosRepository: repository)..add(LoadTodos());
          },
        ),
        BlocProvider<TabBloc>(
          create: (context) => TabBloc(AppTab.todos),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(ThemeTab.light),
        ),
        // BlocProvider<FilteredTodosBloc>(
        //   create: (context) => FilteredTodosBloc(todosBloc: todosBloc),
        // ),
        // BlocProvider<StatsBloc>(
        //   create: (context) => StatsBloc(todosBloc: todosBloc),
        // ),
      ],
      child: const MyApp(),
    ),
  );
}

// class TodosApp extends StatelessWidget {
//   const TodosApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final todosBloc = BlocProvider.of<TodosBloc>(context);

//     return MaterialApp(
//       // onGenerateTitle: (context) =>
//       //     FlutterBlocLocalizations.of(context).appTitle,
//       theme: ArchSampleTheme.theme,
//       home: ,
//       // localizationsDelegates: [
//       //   ArchSampleLocalizationsDelegate(),
//       //   FlutterBlocLocalizationsDelegate(),
//       // ],
//       // routes: {
//       //   ArchSampleRoutes.home: (context) {
//       //     return MultiBlocProvider(
//       //       providers: [
//       //         BlocProvider<TabBloc>(
//       //           create: (context) => TabBloc(),
//       //         ),
//       //         BlocProvider<FilteredTodosBloc>(
//       //           create: (context) => FilteredTodosBloc(todosBloc: todosBloc),
//       //         ),
//       //         BlocProvider<StatsBloc>(
//       //           create: (context) => StatsBloc(todosBloc: todosBloc),
//       //         ),
//       //       ],
//       //       child: HomeScreen(),
//       //     );
//       //   },
//       //   ArchSampleRoutes.addTodo: (context) {
//       //     return AddEditScreen(
//       //       key: ArchSampleKeys.addTodoScreen,
//       //       onSave: (task, note) {
//       //         todosBloc.add(AddTodo(Todo(task, note: note)));
//       //       },
//       //       isEditing: false,
//       //     );
//       //   },
//       // },
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeTab>(builder: (context, activeTab) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: activeTab == ThemeTab.light ? themeLight : themeDark,
        home: const MainScreen(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
