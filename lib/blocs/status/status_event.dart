import 'package:equatable/equatable.dart';
import 'package:todos_repository/todos_repository.dart';

abstract class StatusEvent extends Equatable {
  const StatusEvent();
}

class UpdateStatus extends StatusEvent {
  final List<Todo> todos;

  const UpdateStatus(this.todos);

  @override
  List<Object> get props => todos;

  @override
  String toString() => 'UpdateStatus { todos: $todos }';
}