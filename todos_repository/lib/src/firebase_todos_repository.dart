import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todos_repository/todos_repository.dart';
import 'entities/entities.dart';

class FirebaseTodosRepository implements TodosRepository {
  final todoCollection = Firestore.instance.collection('todos');

  @override
  Future<void> addNewTodo(Todo todo) {
    return todoCollection.add(todo.todoEntity().toDocument());
  }

  @override
  Future<void> deleteTodo(Todo todo) {
    return todoCollection.document(todo.id).delete();
  }

  @override
  Stream<List<Todo>> todos() {
    return todoCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Todo.fromEntity(TodoEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateTodo(Todo todo) {
    return todoCollection
        .document(todo.id)
        .updateData(todo.todoEntity().toDocument());
  }
}