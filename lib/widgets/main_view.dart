import 'package:fake_dona_app/blocs/blocs.dart';
import 'package:fake_dona_app/models/todo.dart';
import 'package:fake_dona_app/widgets/custom_todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final inputField = TextEditingController();

  @override
  void dispose() {
   inputField.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);
    return BlocBuilder<TodosBloc, TodosState>(builder: (context, state) {
      if (state is TodosLoading) {
        return const Center(
          child: Text('Loading All Todos'),
        );
      } else if (state is TodosLoaded) {
        final todos = state;
        return Container(
          color: Theme.of(context).backgroundColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: 80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: inputField,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.5),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.5),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800], fontSize: 14.0),
                  hintText: "Write a new task",
                  contentPadding: const EdgeInsets.only(
                    left: 13.0,
                  ),
                  fillColor: const Color(0xFFDFE1E5),
                ),
                onFieldSubmitted: (val) {
                  if (val.isNotEmpty) {
                    debugPrint(val);
                    todosBloc.add(AddTodo(Todo(val, note: val)));
                    inputField.clear();
                  }
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: todos.todos.length,
                    itemBuilder: (context, index) {
                      return CustomTodos(
                        title: todos.todos[index].task,
                      );
                    }),
              ),
            ],
          ),
        );
      } else {
        return const Center(
          child: Text('No Todos here'),
        );
      }
    });
  }
}
