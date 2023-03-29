class UserModel {
  int id;
  String name;
  String email;
  String password;
  String role;
  String card_id;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.card_id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'], 
    name: json['name'], 
    email: json['email'], 
    password: json['password'], 
    role: json['role'],
    card_id: json['card_id'],
  );
}
