import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semester_5_labs/lab_no_10/crud_using_getx/student_controller.dart';
import 'package:semester_5_labs/lab_no_10/crud_using_getx/student_model.dart';

class StudentForm extends StatelessWidget {
  final StudentController controller = Get.find();
  final Student? student;

  StudentForm({this.student});

  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (student != null) {
      nameCtrl.text = student!.name;
      ageCtrl.text = student!.age.toString();
    }

    return AlertDialog(
      title: Text(student == null ? 'Add Student' : 'Edit Student'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Name')),
          TextField(
            controller: ageCtrl,
            decoration: InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            final name = nameCtrl.text;
            final age = int.tryParse(ageCtrl.text) ?? 0;
            if (name.isNotEmpty && age > 0) {
              if (student == null) {
                controller.addStudent(Student(name: name, age: age));
              } else {
                controller.updateStudent(Student(id: student!.id, name: name, age: age));
              }
              Get.back();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
