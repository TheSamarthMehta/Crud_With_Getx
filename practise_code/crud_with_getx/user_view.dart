import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semester_5_labs/practise_code/crud_with_getx/user_controller.dart';

class UserView extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  int? editingId;

  void clearInputs() {
    nameController.clear();
    emailController.clear();
    editingId = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GetX CRUD Example")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
                TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
                ElevatedButton(
                  onPressed: () {
                    if (editingId == null) {
                      userController.addUser(nameController.text, emailController.text);
                    } else {
                      userController.updateUser(editingId!, nameController.text, emailController.text);
                    }
                    clearInputs();
                  },
                  child: Text(editingId == null ? "Add User" : "Update User"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: userController.userList.length,
              itemBuilder: (context, index) {
                final user = userController.userList[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () {
                        nameController.text = user.name;
                        emailController.text = user.email;
                        editingId = user.id;
                      }),
                      IconButton(icon: Icon(Icons.delete), onPressed: () {
                        userController.deleteUser(user.id);
                      }),
                    ],
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
