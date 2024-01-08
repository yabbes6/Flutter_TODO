import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_todo/data/firestor.dart';

abstract class AuthenticationDatasource {
  Future<void> register(String email, String password, String confirmPassword);
  Future<void> login(String email, String password);
  Future<void> logout();
}

class AuthenticationRemote extends AuthenticationDatasource {
  @override
  Future<void> login(String email, String password) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> register(
      String email, String password, String confirmPassword) async {
    if (confirmPassword == password) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Firestore_Datasource().CreateUser(email);
      });
    }
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }
}
