import 'package:get/get.dart';
import 'package:semester_5_labs/practise_code/crud_with_getx/user_model.dart';

class UserController extends GetxController {
  var userList = <User>[].obs;
  var userIdCounter = 1;

  // Create
  void addUser(String name, String email) {
    userList.add(User(id: userIdCounter++, name: name, email: email));
  }

  // Read – already reactive with userList

  // Update
  void updateUser(int id, String name, String email) {
    int index = userList.indexWhere((u) => u.id == id);
    if (index != -1) {
      userList[index] = User(id: id, name: name, email: email);
    }
  }

  // Delete
  void deleteUser(int id) {
    userList.removeWhere((u) => u.id == id);
  }
}
