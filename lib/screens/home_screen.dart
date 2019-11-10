import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore_todos/blocs/blocs.dart';
import 'package:flutter_firestore_todos/models/models.dart';
import 'package:flutter_firestore_todos/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  final _todosTabBar = [
    'Active',
    'Completed',
  ];
  final _statusTabBar = [
    'Active',
    'Completed',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, BottomNavigationTab>(
      builder: (context, activeTab) {
        return DefaultTabController(
          length: activeTab == BottomNavigationTab.todos
            ? _todosTabBar.length
            : _statusTabBar.length,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Firestore Todos'),
              bottom: TabBar(
                tabs: activeTab == BottomNavigationTab.todos
                    ? _todosTabBar.map((String name) => Tab(text: name)).toList()
                    : _statusTabBar.map((String name) => Tab(text: name)).toList(),
              ),
              actions: <Widget>[
//                FilterButton(visible: activeTab == BottomNavigationTab.todos),
                ExtraActions(),
              ],
            ),
            body: TabBarView(
              children: activeTab == BottomNavigationTab.todos
                  ? <Widget>[
                FilteredTodos(activeTab: TodosTabBar.Active),
                FilteredTodos(activeTab: TodosTabBar.Completed),
              ]
                  : <Widget>[
                Status(activeTab: TodosTabBar.Active),
                Status(activeTab: TodosTabBar.Completed),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addTodo');
              },
              child: Icon(Icons.add),
              tooltip: 'Add Todo',
            ),
            bottomNavigationBar: BottomTabSelector(
              activeTab: activeTab,
              onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
            ),
          ),
        );
      },
    );
  }
}