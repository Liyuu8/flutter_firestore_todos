import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore_todos/blocs/blocs.dart';
import 'package:flutter_firestore_todos/models/models.dart';
import 'package:flutter_firestore_todos/widgets/widgets.dart';
import 'package:flutter_firestore_todos/screens/screens.dart';

class FilteredTodos extends StatelessWidget {
  final TodosTabBar activeTab;

  FilteredTodos({
    Key key,
    @required this.activeTab
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if(state is FilteredTodosLoading) {
          return LoadingIndicator();
        } else if(state is FilteredTodosLoaded) {
          final todos = activeTab == TodosTabBar.Active
            ? state.filteredTodos.where((todo) => !todo.complete).toList()
            : state.filteredTodos.where((todo) => todo.complete).toList();
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoItem(
                todo: todo,
                onDismessed: (direction) {
                  BlocProvider.of<TodosBloc>(context).add(DeleteTodo(todo));
                  Scaffold.of(context).showSnackBar(
                    DeleteTodoSnackBar(
                      todo: todo,
                      onUndo: () => BlocProvider.of<TodosBloc>(context)
                          .add(AddTodo(todo)),
                    ),
                  );
                },
                onTap: () async {
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return DetailScreen(id: todo.id);
                      },
                    ),
                  );
                  if(removedTodo != null) {
                    Scaffold.of(context).showSnackBar(
                      // TODO: Why DeleteTodoSnackBar?
                      DeleteTodoSnackBar(
                        todo: todo,
                        onUndo: () => BlocProvider.of<TodosBloc>(context)
                          .add(AddTodo(todo)),
                      ),
                    );
                  }
                },
                onCheakboxChanged: (_) {
                  BlocProvider.of<TodosBloc>(context).add(
                    UpdateTodo(todo.copyWith(complete: !todo.complete))
                  );
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}