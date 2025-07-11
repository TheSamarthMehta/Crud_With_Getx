import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:semester_5_labs/lab_no_10/crud_using_getx/student_model.dart';
class DBService {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'student.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            age INTEGER
          )
        ''');
      },
    );
  }

  static Future<int> insert(Student student) async {
    final db = await database;
    return await db.insert('students', student.toMap());
  }

  static Future<int> update(Student student) async {
    final db = await database;
    return await db.update('students', student.toMap(), where: 'id = ?', whereArgs: [student.id]);
  }

  static Future<int> delete(int id) async {
    final db = await database;
    return await db.delete('students', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Student>> getStudents({int offset = 0, int limit = 10, String? query}) async {
    final db = await database;
    final whereClause = query != null && query.isNotEmpty
        ? "WHERE name LIKE ? OR age LIKE ?"
        : "";

    final result = await db.rawQuery(
      '''
      SELECT * FROM students 
      $whereClause 
      ORDER BY id DESC 
      LIMIT ? OFFSET ?
      ''',
      query != null && query.isNotEmpty
          ? ['%$query%', '%$query%', limit, offset]
          : [limit, offset],
    );

    return result.map((e) => Student.fromMap(e)).toList();
  }
}
