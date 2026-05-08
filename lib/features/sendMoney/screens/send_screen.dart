import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/send_bloc.dart';
import 'package:flutter/services.dart';
import '../../login/bloc/login_bloc.dart';
import '../../login/screens/login_screen.dart';

class SendPage extends StatelessWidget {
  SendPage({super.key});

  final TextEditingController recipientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void _submit(BuildContext context) {
    final recipientId = recipientController.text.trim();
    final amount = double.tryParse(amountController.text.trim()) ?? 0;
    
    context.read<SendBloc>().add(
          SendMoneyRequested(
            recipientId: recipientId,
            amount: amount,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<LoginBloc>().add(LogoutRequested());
              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<SendBloc, SendState>(
        builder: (context, state) {

          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.sentSuccess == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Transaction successful'),
                ),
              );
            });
          }

          if (state.sentSuccess == false) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
            });
          }

          final wallet = state.sentSuccess;

          return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: recipientController,
                    decoration: const InputDecoration(
                      labelText: 'Recipient Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                    ],
                    controller: amountController,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () => _submit(context),
                    child: state.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Send Money'),
                  ),
                ],
              );
        },
      ),
    );
  }
  
}