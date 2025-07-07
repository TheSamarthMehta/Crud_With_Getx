import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';

class HomeScreen extends StatelessWidget {
  final UserController controller = Get.put(UserController()); // Singleton

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: Obx(() {
        if (controller.users.isEmpty) {
          return Center(child: Text("No users found"));
        }
        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (_, i) {
            final user = controller.users[i];
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.deleteUser(user.id!),
              ),
              onTap: () => Get.toNamed('/form', arguments: user),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/form'),
        child: Icon(Icons.add),
      ),
    );
  }
}
