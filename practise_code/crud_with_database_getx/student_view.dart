import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semester_5_labs/practise_code/crud_with_database_getx/student_controller.dart';
import 'package:semester_5_labs/practise_code/crud_with_database_getx/student_model.dart';

class StudentView extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  void _showDialog({Student? student}) {
    nameCtrl.text = student?.name ?? '';
    emailCtrl.text = student?.email ?? '';

    Get.defaultDialog(
      title: student == null ? "Add Student" : "Edit Student",
      content: Column(
        children: [
          TextField(controller: nameCtrl, decoration: InputDecoration(labelText: "Name")),
          TextField(controller: emailCtrl, decoration: InputDecoration(labelText: "Email")),
        ],
      ),
      textConfirm: "Save",
      onConfirm: () {
        if (student == null) {
          controller.addStudent(Student(name: nameCtrl.text, email: emailCtrl.text));
        } else {
          controller.updateStudent(Student(id: student.id, name: nameCtrl.text, email: emailCtrl.text));
        }
        Get.back();
      },
      textCancel: "Cancel",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student DB with GetX")),
      body: Obx(() => ListView.builder(
        itemCount: controller.studentList.length,
        itemBuilder: (_, index) {
          final student = controller.studentList[index];
          return ListTile(
            title: Text(student.name),
            subtitle: Text(student.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.edit), onPressed: () => _showDialog(student: student)),
                IconButton(icon: Icon(Icons.delete), onPressed: () => controller.deleteStudent(student.id!)),
              ],
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showDialog(),
      ),
    );
  }
}
