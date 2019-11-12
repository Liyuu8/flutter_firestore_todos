import 'dart:async';

abstract class UserRepository {
  Future<bool> isSignedIn();
//  Future<void> authenticate();
  Future<String> getUser();
}