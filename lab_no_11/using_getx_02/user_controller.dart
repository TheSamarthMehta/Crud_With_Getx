import 'package:get/get.dart';
import 'package:semester_5_labs/lab_no_11/using_getx_02/api_service.dart';
import 'package:semester_5_labs/lab_no_11/using_getx_02/request_status.dart';
import 'package:semester_5_labs/lab_no_11/using_getx_02/user_model.dart';


class UserController extends GetxController {
  var users = <User>[].obs;
  var status = RequestStatus.loading.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    status.value = RequestStatus.loading;
    try {
      final fetchedUsers = await ApiService.fetchUsers();
      users.assignAll(fetchedUsers);
      status.value = RequestStatus.success;
    } catch (e) {
      errorMessage.value = e.toString();
      status.value = RequestStatus.error;
    }
  }
}
