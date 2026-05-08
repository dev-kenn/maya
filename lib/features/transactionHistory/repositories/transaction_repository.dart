import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/models/transactions.dart';

class TransactionRepository {

  //i cannot get the mock api to return me a plain json array without adding keys. 
  // so im not including the decoding here

  // Future<List<Transaction>> getAllTransactions({
  //   required String userId
  // }) async {
  //   //I shouldn't be passing token and userID in body here, but i need it to demonstrate usermodel decode
  //   final response = await http.post(
  //     Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode([
  //       {
  //       'userId':"userId",
  //       'recipient':"recipient",
  //       'amount':"amount",
  //       'date':"date",
  //     }
  //     ]),
  //   );
  //   final data = jsonDecode(response.body) as List;

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     return data.map((e) => Transaction.fromJson(e)).toList();
  //   } else {
  //     throw Exception('Transaction failed');
  //   }
  // }

  Future<bool> getAllTransactions({
    required String userId
  }) async {
    //I shouldn't be passing token and userID in body here, but i need it to demonstrate usermodel decode
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode([
        {
        'userId':"userId",
        'recipient':"recipient",
        'amount':"amount",
        'date':"date",
      }
      ]),
    );
    //i cannot get the mock api to return me a plain json array without adding keys. 
    // so im not including the decoding here
    // final data = jsonDecode(response.body) as List;
  
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Transaction failed');
    }
  }
}