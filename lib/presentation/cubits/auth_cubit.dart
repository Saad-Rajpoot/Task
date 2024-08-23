import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:task/core/constants/constant.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  AuthCubit(this.signInUseCase, this.signUpUseCase) : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await signInUseCase(email, password);
      emit(AuthSuccess(user!));
    }  on FirebaseAuthException catch (e) {
      String errorMessage = Constant.getFirebaseAuthErrorMessage(e);
      emit(AuthError(errorMessage));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }


  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await signUpUseCase(email, password);
      emit(AuthSuccess(user!));
    } on FirebaseAuthException catch (e) {
      String errorMessage = Constant.getFirebaseAuthErrorMessage(e);
      emit(AuthError(errorMessage));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.signOut();
      emit(AuthInitial());
    }on FirebaseAuthException catch (e) {
      String errorMessage = Constant.getFirebaseAuthErrorMessage(e);
      emit(AuthError(errorMessage));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }


}
