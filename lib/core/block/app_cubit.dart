import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_state.dart';
import '../models/transactions.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void setBalance(double value) {
    emit(state.copyWith(balance: value));
  }

  void subtractBalance(double value) {
    emit(state.copyWith(balance: state.balance - value));
  }

  void addTransaction(Transaction tx) {
    subtractBalance(tx.amount);
    final updatedList = List<Transaction>.from(state.transactions)
      ..add(tx);

    emit(state.copyWith(transactions: updatedList));
  }
}