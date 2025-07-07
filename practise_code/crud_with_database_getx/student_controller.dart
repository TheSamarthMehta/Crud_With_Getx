import 'package:get/get.dart';
import 'package:semester_5_labs/practise_code/crud_with_database_getx/database_helper.dart';
import 'package:semester_5_labs/practise_code/crud_with_database_getx/student_model.dart';


class StudentController extends GetxController {
  var studentList = <Student>[].obs;

  void loadStudents() async {
    final data = await DatabaseHelper.instance.getStudents();
    studentList.value = data;
  }

  void addStudent(Student student) async {
    await DatabaseHelper.instance.insertStudent(student);
    loadStudents();
  }

  void deleteStudent(int id) async {
    await DatabaseHelper.instance.deleteStudent(id);
    loadStudents();
  }

  void updateStudent(Student student) async {
    await DatabaseHelper.instance.updateStudent(student);
    loadStudents();
  }

  @override
  void onInit() {
    loadStudents();
    super.onInit();
  }
}
