import 'package:firebase_auth/firebase_auth.dart';
import 'package:skype_clone/resources/firebase_methods.dart';

class FirebaseRepository {
  FirebaseMethod _firebaseMethod = FirebaseMethod();

  Future<FirebaseUser> getCurrentUser() => _firebaseMethod.getCurrentUser();

  Future<FirebaseUser> signIn() => _firebaseMethod.signIn();

  Future<bool> authenticateUser(FirebaseUser user) => _firebaseMethod.authenticateUser(user);

  Future<FirebaseUser> addDataToDb(FirebaseUser user) => _firebaseMethod.addDataToDb(user);
}
