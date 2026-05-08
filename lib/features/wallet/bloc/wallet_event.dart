part of 'wallet_bloc.dart';

abstract class WalletEvent {}

class FetchWalletEvent extends WalletEvent {

  FetchWalletEvent();
}

class ToggleBalanceVisibility extends WalletEvent {}