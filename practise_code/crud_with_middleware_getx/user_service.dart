import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class UserService {
  final String baseUrl =
      'https://67c7fdb3c19eb8753e7bbfe6.mockapi.io/api/Middleware'; // Replace with your API

  Future<List<User>> getUsers() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      final jsonList =
          json.decode(res.body)['users']; // Adjust if your JSON differs
      return List<User>.from(jsonList.map((u) => User.fromJson(u)));
    } else {
      throw Exception("Failed to load users");
    }
  }

  Future<void> addUser(User user) async {
    await http.post(Uri.parse(baseUrl), body: user.toJson());
  }

  Future<void> updateUser(User user) async {
    await http.put(Uri.parse('$baseUrl/${user.id}'), body: user.toJson());
  }

  Future<void> deleteUser(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
