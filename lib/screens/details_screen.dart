import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore_todos/blocs/todos/todos.dart';
import 'package:flutter_firestore_todos/screens/screens.dart';

class DetailScreen extends StatelessWidget {
  final String id;

  DetailScreen({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        final todo = (state as TodosLoaded).todos.firstWhere(
                (todos) => todos.id == id, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text('Todo Details'),
            actions: <Widget>[
              IconButton(
                tooltip: 'Delete Todo',
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<TodosBloc>(context).add(DeleteTodo(todo));
                  Navigator.pop(context, todo);
                },
              )
            ],
          ),
          body: todo == null
            ? Container()
            : Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Checkbox(
                          value: todo.complete,
                          onChanged: (_) {
                            BlocProvider.of<TodosBloc>(context).add(
                              UpdateTodo(
                                todo.copyWith(complete: !todo.complete),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Hero(
                              tag: '${todo.id}__heroTag',
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 16.0,
                                ),
                                child: Text(
                                  todo.task,
                                  style: Theme.of(context).textTheme.headline,
                                ),
                              ),
                            ),
                            Text(
                              todo.note,
                              style: Theme.of(context).textTheme.subhead,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Edit Todo',
            child: Icon(Icons.edit),
            onPressed: todo == null
              ? null
              : () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AddEditScreen(
                        onSave: (task, note) {
                          BlocProvider.of<TodosBloc>(context).add(
                            UpdateTodo(
                              todo.copyWith(task: task, note: note),
                            ),
                          );
                        },
                        isEditing: true,
                        todo: todo,
                      );
                    },
                  ),
                );
              },
          ),
        );
      },
    );
  }
}