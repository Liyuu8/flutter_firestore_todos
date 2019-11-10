import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore_todos/models/models.dart';

class BottomTabSelector extends StatelessWidget {
  final BottomNavigationTab activeTab;
  final Function(BottomNavigationTab) onTabSelected;

  BottomTabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: BottomNavigationTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(BottomNavigationTab.values[index]),
      items: BottomNavigationTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == BottomNavigationTab.todos ? Icons.list : Icons.show_chart,
          ),
          title: Text(
            tab == BottomNavigationTab.todos
                ? 'Todos'
                : 'Status',
          ),
        );
      }).toList(),
    );
  }
}