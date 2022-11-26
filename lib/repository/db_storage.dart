import 'package:fake_dona_app/repository/db_models.dart/todo_list.dart';
import 'package:fake_dona_app/repository/db_models.dart/todo_model.dart';
import 'package:fake_dona_app/repository/todo_entity.dart';
import 'package:fake_dona_app/repository/todos_repository.dart';
import 'package:isar/isar.dart';

class DBSTORAGE implements TodosRepository {
  late Future<Isar> db;

  DBSTORAGE() {
    db = openDB();
  }

  @override
  Future<List<TodoEntity>> loadTodos() {
    return Future.delayed(
        const Duration(milliseconds: 3000),
        () => [
              TodoEntity(
                'Buy wine for da kitty',
                '1',
                'With the chickeny bits!',
                false,
              ),
              TodoEntity(
                'Find a Red Sea dive trip',
                '2',
                'Echo vs MY Dream',
                false,
              ),
              TodoEntity(
                'Book flights to Egypt',
                '3',
                '',
                true,
              ),
              TodoEntity(
                'Decide on accommodation',
                '4',
                '',
                false,
              ),
              TodoEntity(
                'Sip Margaritas',
                '5',
                'on the beach',
                true,
              ),
            ]);
  }

  @override
  Future saveTodos(List<TodoEntity> todos) {
    // TODO: implement saveTodos
    throw UnimplementedError();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [TodoModelSchema, TodoListSchema],
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
