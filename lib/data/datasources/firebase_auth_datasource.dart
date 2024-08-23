import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/core/constants/constant.dart';
import '../models/user_model.dart';

abstract class FirebaseAuthDatasource {
  Future<UserModel?> signIn(String email, String password);
  Future<UserModel?> signUp(String email, String password);
  Future<void> signOut();
}

class FirebaseAuthDatasourceImpl implements FirebaseAuthDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserModel?> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        return UserModel.fromFirebaseUser(user);
      }
      return null;
    }  on FirebaseAuthException catch (e) {
      String errorMessage = Constant.getFirebaseAuthErrorMessage(e);
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel?> signUp(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user != null) {
        return UserModel.fromFirebaseUser(user);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      String errorMessage = Constant.getFirebaseAuthErrorMessage(e);
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    }
    on FirebaseAuthException catch (e) {
      String errorMessage = Constant.getFirebaseAuthErrorMessage(e);
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
