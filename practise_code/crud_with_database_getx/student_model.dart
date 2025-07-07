class Student {
  int? id;
  String name;
  String email;

  Student({this.id, required this.name, required this.email});

  factory Student.fromMap(Map<String, dynamic> map) => Student(
    id: map['id'],
    name: map['name'],
    email: map['email'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
  };
}
