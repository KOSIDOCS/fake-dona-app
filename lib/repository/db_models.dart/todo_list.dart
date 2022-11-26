
import 'package:fake_dona_app/repository/db_models.dart/todo_model.dart';
import 'package:isar/isar.dart';

part 'todo_list.g.dart';

@collection
class TodoList {
  Id id = Isar.autoIncrement;

  String? name;
  String? icon;
  String? iconType;

  @Backlink(to: 'todoList')
  final todos = IsarLinks<TodoModel>();
}