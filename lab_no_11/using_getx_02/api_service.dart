import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:semester_5_labs/lab_no_11/using_getx_02/user_model.dart';

class ApiService {
  static const String url = "https://jsonplaceholder.typicode.com/users";

  static Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<User>.from(data.map((item) => User.fromJson(item)));
    } else {
      throw Exception("Failed to load users");
    }
  }
}
