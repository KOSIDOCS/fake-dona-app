import 'package:fake_dona_app/repository/db_storage.dart';
import 'package:fake_dona_app/repository/key_value_storage.dart';
import 'package:fake_dona_app/repository/repository.dart';
import 'package:fake_dona_app/run_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runBlocLibraryApp(LocalStorageRepository(
    localStorage: KeyValueStorage(
      'fake-dona-app',
      await SharedPreferences.getInstance(),
    ),
    dbStorage: DBSTORAGE(),
  ));
}