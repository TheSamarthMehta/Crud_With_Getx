import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semester_5_labs/lab_no_11/using_getx_01/user_controller.dart';


class UserListView extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userController.error.isNotEmpty) {
          return Center(child: Text(userController.error.value));
        }

        return ListView.builder(
          itemCount: userController.userList.length,
          itemBuilder: (context, index) {
            final user = userController.userList[index];
            return Card(
              margin: const EdgeInsets.all(8),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(user.name[0]),
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                title: Text(user.name),
                subtitle: Text(user.email),
              ),
            );
          },
        );
      }),
    );
  }
}
