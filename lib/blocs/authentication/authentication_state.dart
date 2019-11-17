import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final FirebaseUser user;

  Authenticated(this.user);

  @override
  List<Object> get props => [user.email];

  @override
  String toString() => 'Authenticated { UserEmail: ${user.email} }';
}

class Unauthenticated extends AuthenticationState {}
