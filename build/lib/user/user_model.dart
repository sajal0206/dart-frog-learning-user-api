/// UserModel
class UserModel {
  /// UserModel Constructor
  const UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.age,
  });

  /// method to convert from json
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      userName: json['name'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
    );
  }

  /// variable id
  final int id;

  /// variable name
  final String userName;

  /// variable email
  final String email;

  /// variable age
  final int age;

  /// function to convert to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'age': age,
    };
  }
}
