import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore_todos/blocs/status/status.dart';
import 'package:flutter_firestore_todos/models/models.dart';
import 'package:flutter_firestore_todos/widgets/widgets.dart';

class Status extends StatelessWidget {
  final TodosTabBar activeTab;

  Status({
    Key key,
    @required this.activeTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusBloc, StatusState>(
      builder: (context, state) {
        if(state is StatusLoading) {
          return LoadingIndicator();
        } else if(state is StatusLoaded) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: activeTab == TodosTabBar.Active
                  ? <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Active Todos',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        '${state.numActive}',
                        style: Theme.of(context).textTheme.subhead,
                      ),
                    ),
                  ]
                  : <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Completed Todos',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        '${state.numCompleted}',
                        style: Theme.of(context).textTheme.subhead,
                      ),
                    ),
                  ],
            ),
          );
        }
        return Container();
      },
    );
  }
}