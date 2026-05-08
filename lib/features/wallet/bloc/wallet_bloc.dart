import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/wallet_model.dart';
import '../repositories/wallet_repository.dart';
import '../../../core/block/app_cubit.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository repository;
  final AppCubit appCubit;
  

  WalletBloc(this.repository, {required this.appCubit})
      : super(const WalletState()) {
    on<FetchWalletEvent>(_fetchWallet);
    on<ToggleBalanceVisibility>(_toggleBalance);
  }

  Future<void> _fetchWallet(
    FetchWalletEvent event,
    Emitter<WalletState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final wallet = await repository.fetchWalletBalance();
      appCubit.setBalance(wallet.balance);
      emit(state.copyWith(
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _toggleBalance(
    ToggleBalanceVisibility event,
    Emitter<WalletState> emit,
  ) {
    emit(
      state.copyWith(
        isBalanceHidden: !state.isBalanceHidden,
      ),
    );
  }
}