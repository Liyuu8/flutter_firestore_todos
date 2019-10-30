import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String id;
  final String task;
  final String note;
  final bool complete;

  TodoEntity(this.id, this.task, this.note, this.complete);

  Map<String, Object> toJson() {
    return {
      'id' : id,
      'task' : task,
      'note' : note,
      'complete' : complete,
    };
  }

  static TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity(
      json['id'] as String,
      json['task'] as String,
      json['note'] as String,
      json['complete'] as bool,
    );
  }

  @override
  String toString() {
    return 'TodoEntity { id: $id, task: $task, note: $note, complete: $complete }';
  }

  static TodoEntity fromSnapshot(DocumentSnapshot snap) {
    return TodoEntity(
      snap.documentID,
      snap.data['task'],
      snap.data['note'],
      snap.data['complete'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'task' : task,
      'note' : note,
      'complete' : complete,
    };
  }
}