import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthRepository {
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    //I shouldn't be passing token and userID in body here, but i need it to demonstrate usermodel decode
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
        'token':'randomToken',
        'userId':"123"
      }),
    );

    final data = jsonDecode(response.body);

    //should be 200, but the mock api is only sending 201
    if (response.statusCode == 201) {
      return UserModel.fromJson(data);
    } else {
      throw Exception(data['error'] ?? 'Login failed');
    }
  }
}