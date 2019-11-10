import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_firestore_todos/blocs/tab/tab.dart';
import 'package:flutter_firestore_todos/models/models.dart';

class TabBloc extends Bloc<TabEvent, BottomNavigationTab> {
  @override
  BottomNavigationTab get initialState => BottomNavigationTab.todos;

  @override
  Stream<BottomNavigationTab> mapEventToState(TabEvent event) async* {
    if(event is UpdateTab) {
      yield event.tab;
    }
  }
}