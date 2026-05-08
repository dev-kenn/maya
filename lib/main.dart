import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/features/wallet/screens/wallet_screen.dart';

import 'features/login/bloc/login_bloc.dart';
import 'features/login/screens/login_screen.dart';
import 'features/login/repositories/auth_repository.dart';
import 'core/block/app_cubit.dart';
import 'features/transactionHistory/bloc/transaction_bloc.dart';
import 'features/transactionHistory/repositories/transaction_repository.dart';
import 'features/wallet/bloc/wallet_bloc.dart';
import 'features/wallet/repositories/wallet_repository.dart';

void main() {
  // runApp(const MyApp());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc(
          AuthRepository()
        )),
        BlocProvider(create: (_) => AppCubit()), 
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AppRoot(),
    );
  }
}


class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccess) {
          return BlocProvider(
            create: (_) => WalletBloc(
              WalletRepository(),
              appCubit: context.read<AppCubit>(),
            ),
            child: const WalletScreen(),
          );
        }

        return const LoginScreen();
      },
    );
  }
}