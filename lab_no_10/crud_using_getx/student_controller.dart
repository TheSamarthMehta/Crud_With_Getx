import 'package:get/get.dart';
import 'package:semester_5_labs/lab_no_10/crud_using_getx/student_model.dart';
import 'package:semester_5_labs/lab_no_10/crud_using_getx/db_service.dart';

class StudentController extends GetxController {
  var students = <Student>[].obs;
  var searchQuery = ''.obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 0;
  final limit = 10;

  @override
  void onInit() {
    loadStudents(reset: true);
    super.onInit();
  }

  void loadStudents({bool reset = false}) async {
    if (isLoading.value || !hasMore.value) return;

    isLoading(true);
    if (reset) {
      page = 0;
      hasMore(true);
      students.clear();
    }

    final data = await DBService.getStudents(
      offset: page * limit,
      limit: limit,
      query: searchQuery.value,
    );

    students.addAll(data);
    if (data.length < limit) hasMore(false);
    page++;
    isLoading(false);
  }

  void addStudent(Student student) async {
    await DBService.insert(student);
    loadStudents(reset: true);
  }

  void updateStudent(Student student) async {
    await DBService.update(student);
    loadStudents(reset: true);
  }

  void deleteStudent(int id) async {
    await DBService.delete(id);
    loadStudents(reset: true);
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    loadStudents(reset: true);
  }
}
