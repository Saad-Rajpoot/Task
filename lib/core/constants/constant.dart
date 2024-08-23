import 'package:firebase_auth/firebase_auth.dart';

class Constant {

  static String firebaseAppId = '1:812390356490:android:df8bd25b043fc4aa0d31f3';
  static String firebaseApiKey = 'AIzaSyCt6HVxnh0-VV1tqmr8Eyr2OGb624aw3tY';
  static String firebaseMessageSenderId ='812390356490' '';
  static String firebaseProjectId = 'task-6748e';
  static String getFirebaseAuthErrorMessage(FirebaseAuthException exception) {
    print("exception.code : ${exception.code}");
    switch (exception.code) {
      case 'invalid-email':
        return "The email address is not valid.";
      case 'user-disabled':
        return "The user corresponding to the given email has been disabled.";
      case 'user-not-found':
        return "There is no user corresponding to the given email.";
      case 'wrong-password':
        return "The password is invalid or the user does not have a password.";
      case 'email-already-in-use':
        return "The email is already in use by another account.";
      case 'operation-not-allowed':
        return "Email/Password accounts are not enabled.";
      case 'weak-password':
        return "The password provided is too weak.";
      case 'invalid-credential':
        return "The supplied auth credential is incorrect, malformed or has expired.";
      default:
        return "An unknown error occurred. Please try again.";
    }
  }
}