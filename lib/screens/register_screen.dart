import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_firestore_todos/widgets/register/register.dart';
import 'package:flutter_firestore_todos/blocs/register/register.dart';

class RegisterScreen extends StatelessWidget {
  final FirebaseUserRepository _userRepository;

  RegisterScreen({
    Key key,
    @required FirebaseUserRepository userRepository
  }) : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          builder: (context) => RegisterBloc(userRepository: _userRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }
}