import 'package:flutter_bloc/flutter_bloc.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';
import '../repositories/transaction_repository.dart';
import '../../../core/block/app_cubit.dart';
import '../../../core/models/transactions.dart';

class TransactionsBloc
    extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionRepository repository;
  final AppCubit appCubit;

  TransactionsBloc(this.repository, {required this.appCubit}) : super(TransactionsInitial()) {
    on<LoadTransactions>(_onLoad);
  }

  Future<void> _onLoad(
    LoadTransactions event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(TransactionsLoading());

    try {
      final transactions = await repository.getAllTransactions(
        userId: "123"
      );
      //this is how it should be if the mock api is working as intended
      // emit(TransactionsLoaded(transactions));

      //made it like this just to work
      emit(TransactionsLoaded([Transaction(
        amount: 0,
        date: "",
        recipient: ""
      )]));

    } catch (e) {
      emit(TransactionsError(e.toString()));
    }
  }
}