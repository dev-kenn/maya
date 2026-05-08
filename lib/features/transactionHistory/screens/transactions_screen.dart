import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/block/app_cubit.dart';

import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_event.dart';
import '../bloc/transaction_state.dart';

import '../../login/bloc/login_bloc.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {

  
  @override
  void initState() {
    super.initState();
    context.read<TransactionsBloc>().add(LoadTransactions());
  }

  @override
  Widget build(BuildContext context) {
    // i should be using the ones from API here but it has no actual value so im using the ones from local variable
    final transactions = context.watch<AppCubit>().state.transactions;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<LoginBloc>().add(LogoutRequested());
              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (context, state) {
          if (state is TransactionsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TransactionsLoaded) {
            if (transactions.isEmpty) {
              return const Center(child: Text("No transactions"));
            }
            return ListView.builder(
              // itemCount: state.transactions.length,
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];

                return ListTile(
                  title: Text(tx.recipient),
                  subtitle: Text(tx.date.toString()),
                  trailing: Text("₱${tx.amount}"),
                );
              },
            );
          }

          if (state is TransactionsError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text("No transactions"));
        },
      ),
    );
  }
}