import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';
import 'user_model.dart';

class UserFormScreen extends StatelessWidget {
  final UserController controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  User? user;

  @override
  Widget build(BuildContext context) {
    user = Get.arguments;
    if (user != null) {
      nameController.text = user!.name;
      emailController.text = user!.email;
    }

    return Scaffold(
      appBar: AppBar(title: Text(user == null ? "Add User" : "Edit User")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
              validator: (v) => v!.isEmpty ? "Enter name" : null,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
              validator: (v) => v!.isEmpty ? "Enter email" : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final u = User(
                    id: user?.id,
                    name: nameController.text,
                    email: emailController.text,
                  );
                  if (user == null) {
                    controller.addUser(u);
                  } else {
                    controller.updateUser(u);
                  }
                  Get.back();
                }
              },
              child: Text(user == null ? "Add" : "Update"),
            )
          ]),
        ),
      ),
    );
  }
}
