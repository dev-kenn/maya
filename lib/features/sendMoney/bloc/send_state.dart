part of 'send_bloc.dart';

class SendState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final bool isWalletHidden;
  final String recipientId;
  final double amount;
  final bool? sentSuccess;

  const SendState({
    this.isLoading = false,
    this.errorMessage = '',
    this.isWalletHidden = true,
    this.recipientId = '',
    this.amount = 0,
    this.sentSuccess,
  });

  SendState copyWith({
    bool? isLoading,
    bool? isWalletHidden,
    String? errorMessage,
    double? amount,
    String? recipientId,
    bool? sentSuccess
  }) {
    return SendState(
      isLoading: isLoading ?? this.isLoading,
      isWalletHidden: isWalletHidden ?? this.isWalletHidden,
      errorMessage: errorMessage ?? this.errorMessage,
      amount: amount ?? this.amount,
      recipientId: recipientId ?? this.recipientId,
      sentSuccess: sentSuccess ?? this.sentSuccess
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isWalletHidden,
        errorMessage,
        recipientId,
        amount,
        sentSuccess
      ];
}