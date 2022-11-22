import 'dart:async';

import 'package:fake_dona_app/blocs/todos/todos.dart';
import 'package:fake_dona_app/models/models.dart';
import 'package:fake_dona_app/repository/todos_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:meta/meta.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepository todosRepository;

  TodosBloc({required this.todosRepository}) : super(TodosLoading());

  TodosState get initialState => TodosLoading();

  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<TodosState> _mapLoadTodosToState() async* {
    try {
      final todos = await todosRepository.loadTodos();
      yield TodosLoaded(
        todos.map(Todo.fromEntity).toList(),
      );
    } catch (_) {
      yield TodosNotLoaded();
    }
  }

  Stream<TodosState> _mapAddTodoToState(AddTodo event) async* {
    if (state is TodosLoaded) {
      final updatedTodos = List<Todo>.from((state as TodosLoaded).todos)
        ..add(event.todo);
      yield TodosLoaded(updatedTodos);
      await _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    if (state is TodosLoaded) {
      final updatedTodos = (state as TodosLoaded).todos.map((todo) {
        return todo.id == event.updatedTodo.id ? event.updatedTodo : todo;
      }).toList();
      yield TodosLoaded(updatedTodos);
      await _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
    if (state is TodosLoaded) {
      final updatedTodos = (state as TodosLoaded)
          .todos
          .where((todo) => todo.id != event.todo.id)
          .toList();
      yield TodosLoaded(updatedTodos);
      await _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapToggleAllToState() async* {
    if (state is TodosLoaded) {
      final allComplete =
          (state as TodosLoaded).todos.every((todo) => todo.complete);
      final updatedTodos = (state as TodosLoaded)
          .todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      yield TodosLoaded(updatedTodos);
      await _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    if (state is TodosLoaded) {
      final updatedTodos =
          (state as TodosLoaded).todos.where((todo) => !todo.complete).toList();
      yield TodosLoaded(updatedTodos);
      await _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return todosRepository.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }
}