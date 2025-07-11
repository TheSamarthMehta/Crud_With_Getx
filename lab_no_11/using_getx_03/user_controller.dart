import 'package:get/get.dart';
import 'package:semester_5_labs/lab_no_11/using_getx_03/user_model.dart';
import 'package:semester_5_labs/lab_no_11/using_getx_03/api_service.dart';

class UserController extends GetxController {
  var users = <User>[].obs;
  var filteredUsers = <User>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      final data = await ApiService.fetchUsers();
      users.assignAll(data);
      filteredUsers.assignAll(data);
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void filterUsers(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredUsers.assignAll(users);
    } else {
      final results = users.where((user) =>
      user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.email.toLowerCase().contains(query.toLowerCase())
      ).toList();
      filteredUsers.assignAll(results);
    }
  }
}
