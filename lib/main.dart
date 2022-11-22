import 'package:fake_dona_app/repository/key_value_storage.dart';
import 'package:fake_dona_app/repository/repository.dart';
import 'package:fake_dona_app/run_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //final vi = await SharedPreferences.getInstance();

  runBlocLibraryApp(LocalStorageRepository(
    localStorage: KeyValueStorage(
      'bloc_library',
      await SharedPreferences.getInstance(),
    ),
  ));
}
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MainScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }