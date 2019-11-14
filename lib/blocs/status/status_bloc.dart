import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_firestore_todos/blocs/blocs.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  StreamSubscription _todosSubscription;

  StatusBloc({TodosBloc todosBloc}) :
      assert(todosBloc != null) {
        _todosSubscription = todosBloc.listen((state) {
          if(state is TodosLoaded) {
            add(UpdateStatus(state.todos));
          }
        });
      }

  @override
  StatusState get initialState => StatusLoading();

  @override
  Stream<StatusState> mapEventToState(StatusEvent event) async* {
    if(event is UpdateStatus) {
      int numActive = event.todos.where((todo) => !todo.complete).toList().length;
      int numCompleted = event.todos.where((todo) => todo.complete).toList().length;
      yield StatusLoaded(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}