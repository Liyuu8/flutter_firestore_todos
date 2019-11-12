import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_firestore_todos/blocs/login/login.dart';
import 'package:flutter_firestore_todos/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseUserRepository _userRepository;

  LoginScreen({
    Key key,
    @required FirebaseUserRepository userRepository
  }) : assert(userRepository != null),
    _userRepository = userRepository,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider<LoginBloc>(
        builder: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository),
      ),
    );
  }
}