import 'package:fake_dona_app/repository/todo_entity.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

@immutable
class Todo {
  final bool complete;
  final String id;
  final String note;
  final String task;

 const Todo(this.task, {this.complete = false, String note = '', String id = ''})
      // ignore: prefer_initializing_formals
      : note = note,
        // ignore: prefer_initializing_formals
        id = id;

  Todo copyWith({bool? complete, String? id, String? note, String? task}) {
    return Todo(
      task ?? this.task,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  @override
  int get hashCode =>
      complete.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          id == other.id;

  @override
  String toString() {
    return 'Todo{complete: $complete, task: $task, note: $note, id: $id}';
  }

  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      entity.task,
      complete: entity.complete,
      note: entity.note,
      id: entity.id,
    );
  }
}