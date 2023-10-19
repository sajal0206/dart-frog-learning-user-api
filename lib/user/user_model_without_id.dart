/// UserModel
class UserModelNoId {
  /// UserModel Constructor
  const UserModelNoId({
    required this.userName,
    required this.email,
    required this.age,
  });

  /// method to convert from json
  factory UserModelNoId.fromJson(Map<String, dynamic> json) {
    return UserModelNoId(
      userName: json['name'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
    );
  }

  /// variable name
  final String userName;

  /// variable email
  final String email;

  /// variable age
  final int age;

  /// function to convert to json
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'age': age,
    };
  }
}
