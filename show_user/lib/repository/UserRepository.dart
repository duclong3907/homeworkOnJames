import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class UserRepository {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<User>> fetchAllUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}