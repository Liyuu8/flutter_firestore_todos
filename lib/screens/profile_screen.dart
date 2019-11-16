import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore_todos/blocs/authentication/authentication.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if(state is Unauthenticated) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      LoggedOut(),
                    );
                  },
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: state is Authenticated
                      ? Text('Welcome ${state.displayName}')
                      : Text('Please sign in...'),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}