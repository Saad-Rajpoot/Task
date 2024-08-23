import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/auth_cubit.dart';
import '../widgets/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const LoadingIndicator();
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                 const Text('Welcome!', style: TextStyle(fontSize: 24)),
                 const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().signOut();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child:  const Text('Sign Out'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

