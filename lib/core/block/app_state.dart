import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/transactions.dart';


class AppState {
  final double balance;
  final List<Transaction> transactions;

  const AppState({
    this.balance = 0.0,
    this.transactions = const [],
  });

  AppState copyWith({
    double? balance,
    List<Transaction>? transactions,
  }) {
    return AppState(
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
    );
  }
}