import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/constants/constant.dart';
import 'package:task/presentation/cubits/auth_cubit.dart';
import 'package:task/presentation/screens/home_screen.dart';
import 'package:task/presentation/screens/login_screen.dart';
import 'package:task/presentation/screens/signup_screen.dart';
import 'package:task/presentation/widgets/loading_indicator.dart';
import 'data/datasources/firebase_auth_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/sign_in_usecase.dart';
import 'domain/usecases/sign_up_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:  FirebaseOptions(
      apiKey: Constant.firebaseApiKey,
      appId: Constant.firebaseAppId,
      messagingSenderId: Constant.firebaseMessageSenderId,
      projectId: Constant.firebaseProjectId,
    ),
  );
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        SignInUseCase(AuthRepositoryImpl(FirebaseAuthDatasourceImpl())),
        SignUpUseCase(AuthRepositoryImpl(FirebaseAuthDatasourceImpl())),
      ),
      child: MaterialApp(
        title: 'Flutter Firebase Auth',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthCheck(),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/signup': (context) => SignUpScreen(),
        },
      ),
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        } else if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
