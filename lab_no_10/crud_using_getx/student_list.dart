import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semester_5_labs/lab_no_10/crud_using_getx/student_controller.dart';
import 'student_form.dart';

class StudentList extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());
  final scrollCtrl = ScrollController();

  StudentList() {
    scrollCtrl.addListener(() {
      if (scrollCtrl.position.pixels >= scrollCtrl.position.maxScrollExtent - 100) {
        controller.loadStudents();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        backgroundColor: Colors.indigo,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: controller.setSearchQuery,
              decoration: InputDecoration(
                hintText: "Search by name or age...",
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollCtrl,
                itemCount: controller.students.length,
                itemBuilder: (_, i) {
                  final student = controller.students[i];
                  return ListTile(
                    leading: CircleAvatar(child: Text(student.name[0])),
                    title: Text(student.name),
                    subtitle: Text('Age: ${student.age}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => Get.dialog(StudentForm(student: student)),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => controller.deleteStudent(student.id!),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (controller.isLoading.value)
              const Padding(
                padding: EdgeInsets.all(10),
                child: CircularProgressIndicator(),
              ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.dialog(StudentForm()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
