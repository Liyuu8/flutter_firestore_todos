import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todos_repository/todos_repository.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDismessed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheakboxChanged;
  final Todo todo;

  TodoItem({
    Key key,
    @required this.onDismessed,
    @required this.onTap,
    @required this.onCheakboxChanged,
    @required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__todo_item_${todo.id}'),
      onDismissed: onDismessed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          value: todo.complete,
          onChanged: onCheakboxChanged,
        ),
        title: Hero(
          tag: '${todo.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              todo.task,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        subtitle: todo.note.isNotEmpty
          ? Text(
              todo.note,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subhead,
            )
          : null,
      ),
    );
  }
}