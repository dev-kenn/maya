import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/features/sendMoney/bloc/send_bloc.dart';

import '../bloc/wallet_bloc.dart';
import '../../sendMoney/repositories/send_repository.dart';

import '../../sendMoney/screens/send_screen.dart';
import '../../login/bloc/login_bloc.dart';
import '../../../core/block/app_cubit.dart';

import '../../transactionHistory/screens/transactions_screen.dart';
import '../../transactionHistory/bloc/transaction_bloc.dart';
import '../../transactionHistory/repositories/transaction_repository.dart';

class WalletScreen extends StatefulWidget {

  const WalletScreen({
    super.key,
  });

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  @override
  void initState() {
    super.initState();

    context.read<WalletBloc>().add(
      FetchWalletEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<LoginBloc>().add(LogoutRequested());
            },
          ),
        ],
      ),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {

          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // if (state is AuthUnauthenticated) {
          //   AppNavigation.goToLogin(context);
          // }

          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text(state.errorMessage),
            );
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Balance: ',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          state.isBalanceHidden
                              ? '••••••••'
                              : "${context.watch<AppCubit>().state.balance}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),

                      IconButton(
                        icon: Icon(
                          state.isBalanceHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          context
                              .read<WalletBloc>()
                              .add(ToggleBalanceVisibility());
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => SendBloc(
                              SendRepository(),
                              appCubit: context.read<AppCubit>()
                            ),
                            child: SendPage(),
                          ),
                        ),
                      );
                    },
                    child: const Text('Send'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => TransactionsBloc(
                              TransactionRepository(),
                              appCubit: context.read<AppCubit>()
                            ),
                            child: TransactionScreen(),
                          ),
                        ),
                      );
                    },
                    child: const Text('Transaction history'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}