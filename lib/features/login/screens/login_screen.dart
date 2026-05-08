import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../../wallet/bloc/wallet_bloc.dart';
import '../../wallet/repositories/wallet_repository.dart';
import '../../wallet/screens/wallet_screen.dart';
import '../../../core/block/app_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => BlocProvider(
              //       create: (_) => WalletBloc(
              //         WalletRepository(),
              //         appCubit: context.read<AppCubit>()
              //       ),
              //       child: WalletScreen(),
              //     ),
              //   ),
              // );
            }

            if (state is LoginFailure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                  ),
                );
              });
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value) {
                    context
                        .read<LoginBloc>()
                        .add(UsernameChanged(value));
                  },
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    context
                        .read<LoginBloc>()
                        .add(PasswordChanged(value));
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: state is LoginLoading
                        ? null
                        : () {
                            context
                                .read<LoginBloc>()
                                .add(LoginSubmitted());
                          },
                    child: state is LoginLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Login'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}