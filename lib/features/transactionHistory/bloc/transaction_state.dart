import '../../../core/models/transactions.dart';



abstract class TransactionsState {}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  final List<Transaction> transactions;

  TransactionsLoaded(this.transactions);
}

class TransactionsError extends TransactionsState {
  final String message;

  TransactionsError(this.message);
}