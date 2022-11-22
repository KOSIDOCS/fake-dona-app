import 'dart:convert';

import 'package:fake_dona_app/repository/todo_entity.dart';
import 'package:fake_dona_app/repository/todos_repository.dart';

class KeyValueStorage implements TodosRepository {
  final String key;
  final dynamic store;
  final JsonCodec codec;

  const KeyValueStorage(this.key, this.store, [this.codec = json]);

  @override
  Future<List<TodoEntity>> loadTodos() async {
    return codec
        .decode(store.getString(key))['todos']
        .cast<Map<String, Object>>()
        .map<TodoEntity>(TodoEntity.fromJson)
        .toList(growable: false);
  }

  @override
  Future<bool> saveTodos(List<TodoEntity> todos) {
    return store.setString(
      key,
      codec.encode({
        'todos': todos.map((todo) => todo.toJson()).toList(),
      }),
    );
  }
}