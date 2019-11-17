import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todos_repository/todos_repository.dart';
import 'entities/entities.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseTodosRepository implements TodosRepository {
  final CollectionReference _todoCollection;

  FirebaseTodosRepository({FirebaseUser user})
    : _todoCollection = Firestore.instance.collection('users')
      .document(user.uid).collection('todos');

  @override
  Future<void> addNewTodo(Todo todo) {
    return _todoCollection.add(todo.todoEntity().toDocument());
  }

  @override
  Future<void> deleteTodo(Todo todo) {
    return _todoCollection.document(todo.id).delete();
  }

  @override
  Stream<List<Todo>> todos() {
    return _todoCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Todo.fromEntity(TodoEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateTodo(Todo todo) {
    return _todoCollection
        .document(todo.id)
        .updateData(todo.todoEntity().toDocument());
  }
}