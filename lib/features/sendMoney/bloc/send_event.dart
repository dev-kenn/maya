part of 'send_bloc.dart';

abstract class SendEvent {}

class SendMoneyRequested extends SendEvent {
  final String recipientId;
  final double amount;

  SendMoneyRequested({
    required this.recipientId,
    required this.amount,
  });
}