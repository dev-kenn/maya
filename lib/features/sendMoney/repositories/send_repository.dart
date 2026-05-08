import 'dart:convert';
import 'package:http/http.dart' as http;

class SendRepository {

  Future<bool> sendMoney({
    required String recipientId,
    required double amount,
  }) async {
    //I shouldn't be passing token and userID in body here, but i need it to demonstrate usermodel decode
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'amount': amount,
        'recipientId':recipientId,
        'userId':"123"
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception(data['message'] ?? 'Transaction failed');
    }
  }
}