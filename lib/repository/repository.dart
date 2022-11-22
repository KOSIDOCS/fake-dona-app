import 'package:fake_dona_app/repository/todo_entity.dart';
import 'package:fake_dona_app/repository/todos_repository.dart';
import 'package:fake_dona_app/repository/web_client.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class LocalStorageRepository implements TodosRepository {
  final TodosRepository localStorage;
  final TodosRepository webClient;

  const LocalStorageRepository({
    required this.localStorage,
    this.webClient = const WebClient(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<TodoEntity>> loadTodos() async {
    try {
      return await localStorage.loadTodos();
    } catch (e) {
      final todos = await webClient.loadTodos();

      await localStorage.saveTodos(todos);

      return todos;
    }
  }

  // Persists todos to local disk and the web
  @override
  Future saveTodos(List<TodoEntity> todos) {
    return Future.wait<dynamic>([
      localStorage.saveTodos(todos),
      webClient.saveTodos(todos),
    ]);
  }
}