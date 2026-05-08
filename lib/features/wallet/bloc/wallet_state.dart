part of 'wallet_bloc.dart';

class WalletState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final bool isBalanceHidden;

  const WalletState({
    this.isLoading = false,
    this.errorMessage = '',
    this.isBalanceHidden = true,
  });

  WalletState copyWith({
    bool? isLoading,
    bool? isBalanceHidden,
    String? errorMessage
  }) {
    return WalletState(
      isLoading: isLoading ?? this.isLoading,
      isBalanceHidden: isBalanceHidden ?? this.isBalanceHidden,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isBalanceHidden,
        errorMessage
      ];
}