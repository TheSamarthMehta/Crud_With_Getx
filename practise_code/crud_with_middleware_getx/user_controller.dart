import 'package:get/get.dart';
import 'user_model.dart';
import 'user_service.dart';

class UserController extends GetxController {
  var users = <User>[].obs;
  final UserService service = UserService();

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      final data = await service.getUsers();
      users.value = data;
    } catch (e) {
      Get.snackbar("Error", "Failed to load users");
    }
  }

  void addUser(User user) async {
    try {
      await service.addUser(user);
      fetchUsers(); // refresh list from API
    } catch (e) {
      Get.snackbar("Error", "Failed to add user");
    }
  }

  void updateUser(User user) async {
    try {
      await service.updateUser(user);
      fetchUsers();
    } catch (e) {
      Get.snackbar("Error", "Failed to update user");
    }
  }

  void deleteUser(int id) async {
    try {
      await service.deleteUser(id);
      fetchUsers();
    } catch (e) {
      Get.snackbar("Error", "Failed to delete user");
    }
  }
}
