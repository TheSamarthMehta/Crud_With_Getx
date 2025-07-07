class User {
  int? id;
  String name;
  String email;

  User({this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    email: json['email'],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
  };
}
