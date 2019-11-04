import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Todo {
  final String id;
  final String task;
  final String note;
  final bool complete;

  Todo(
    this.task, {
      this.complete = false,
      String note = '',
      String id
    }
  ) : this.note = note ?? '', this.id = id;

  Todo copyWith({bool complete, String id, String note, String task}) {
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
  bool operator == (Object other) =>
      identical(this, other) ||
      other is Todo &&
        runtimeType == other.runtimeType &&
        complete == other.complete &&
        task == other.task &&
        note == other.note &&
        id == other.id;

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, note: $note, id: $id }';
  }

  TodoEntity todoEntity() {
    return TodoEntity(id, task, note, complete);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      entity.task,
      complete: entity.complete ?? false,
      note: entity.note,
      id: entity.id,
    );
  }
}