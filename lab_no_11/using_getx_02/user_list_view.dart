import 'package:flutter/material.dart';
import 'package:semester_5_labs/lab_no_11/using_getx_02/request_status.dart';
import 'package:semester_5_labs/lab_no_11/using_getx_02/user_controller.dart';

import '../../utils/import_export.dart';

class UserListView extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Obx(() {
        switch (userController.status.value) {
          case RequestStatus.loading:
            return const Center(child: CircularProgressIndicator());

          case RequestStatus.success:
            return ListView.builder(
              itemCount: userController.users.length,
              itemBuilder: (context, index) {
                final user = userController.users[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(user.name[0])),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  ),
                );
              },
            );

          case RequestStatus.error:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Error: ${userController.errorMessage}", style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: userController.fetchUsers,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );

          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }
}
