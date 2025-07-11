import 'package:get/get.dart';
import 'package:semester_5_labs/lab_no_11/using_getx_01/api_service.dart';
import 'package:semester_5_labs/lab_no_11/using_getx_01/user_model.dart';


class UserController extends GetxController {
  var isLoading = true.obs;
  var userList = <User>[].obs;
  var error = ''.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      final users = await ApiService.fetchUsers();
      userList.value = users;
      error('');
    } catch (e) {
      error('Failed to fetch users');
    } finally {
      isLoading(false);
    }
  }
}
