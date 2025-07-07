
import 'package:path/path.dart';
import 'package:semester_5_labs/practise_code/crud_with_database_getx/student_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;
  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDB();
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'student.db');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertStudent(Student student) async {
    final db = await instance.database;
    return await db.insert('students', student.toMap());
  }

  Future<List<Student>> getStudents() async {
    final db = await instance.database;
    final result = await db.query('students');
    return result.map((json) => Student.fromMap(json)).toList();
  }

  Future<int> deleteStudent(int id) async {
    final db = await instance.database;
    return await db.delete('students', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateStudent(Student student) async {
    final db = await instance.database;
    return await db.update('students', student.toMap(), where: 'id = ?', whereArgs: [student.id]);
  }
}