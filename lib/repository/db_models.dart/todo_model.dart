
import 'package:fake_dona_app/repository/db_models.dart/todo_list.dart';
import 'package:isar/isar.dart';

part 'todo_model.g.dart';

@collection
class TodoModel {
  Id id = Isar.autoIncrement;

  bool complete = false;
  String? note;
  String? task;  

  final todoList = IsarLink<TodoList>();
}