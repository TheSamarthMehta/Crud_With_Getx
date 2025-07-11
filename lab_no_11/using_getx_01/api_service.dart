import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:semester_5_labs/lab_no_11/using_getx_01/user_model.dart';


class ApiService {
  static const String url = "https://jsonplaceholder.typicode.com/users";

  static Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
