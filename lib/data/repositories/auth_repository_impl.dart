import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<UserEntity?> signIn(String email, String password) async {
    return await datasource.signIn(email, password);
  }

  @override
  Future<UserEntity?> signUp(String email, String password) async {
    return await datasource.signUp(email, password);
  }

  @override
  Future<void> signOut() async {
    return await datasource.signOut();
  }
}
