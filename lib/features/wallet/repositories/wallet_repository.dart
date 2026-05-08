import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/wallet_model.dart';

class WalletRepository {
  Future<WalletModel> fetchWalletBalance() async {
    //I shouldn't be passing balance in body here, but i need it to demonstrate balance decode
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'balance': 500
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return WalletModel.fromJson(data);
    } else {
      throw Exception('Failed to load wallet');
    }
  }
}