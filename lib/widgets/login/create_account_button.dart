import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_firestore_todos/screens/screens.dart';

class CreateAccountButton extends StatelessWidget {
  final FirebaseUserRepository _userRepository;

  CreateAccountButton({
    Key key,
    @required FirebaseUserRepository userRepository,
  }) : assert(userRepository != null),
    _userRepository = userRepository,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(userRepository: _userRepository);
          })
        );
      },
    );
  }
}