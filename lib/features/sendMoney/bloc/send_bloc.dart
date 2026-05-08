import 'dart:async';
import 'dart:ffi';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/core/models/transactions.dart';
import '../../sendMoney/repositories/send_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/block/app_cubit.dart';

part 'send_event.dart';
part 'send_state.dart';

class SendBloc extends Bloc<SendEvent, SendState> {
  final SendRepository sendRepository;
  final AppCubit appCubit;

  SendBloc(this.sendRepository, {required this.appCubit}) : super(SendState()) {
    on<SendMoneyRequested>(_onSendMoneyRequested);
  }

  Future<void> _onSendMoneyRequested(
    SendMoneyRequested event,
    Emitter<SendState> emit,
  ) async {
    double amount = event.amount;
    String recipientId = event.recipientId;
    emit(state.copyWith(
      isLoading: true,
      errorMessage: '',
    ));

    if (amount <= 0) {
      emit(state.copyWith(
        isLoading: false,
        sentSuccess: false,
        errorMessage: 'Amount must be greater than zero',
      ));
      return;
    }
    try {
      final response = await sendRepository.sendMoney(
        amount: amount,
        recipientId: recipientId,
      );
      DateTime _now = DateTime.now();

      String transactionTime = "${_now.hour}:${_now.minute}:${_now.second}.${_now.millisecond}";

      // appCubit.subtractBalance(state.amount);
      appCubit.addTransaction(
        Transaction(recipient: recipientId, amount: amount, date: transactionTime)
      );
      
      emit(state.copyWith(
        isLoading: false,
        sentSuccess: response,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }


  }
}