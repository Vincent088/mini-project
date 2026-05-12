class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String image;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.image,
  });

  String get fullName => '$firstName $lastName';

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int? ?? 0,
        firstName: json['firstName'] as String? ?? '',
        lastName: json['lastName'] as String? ?? '',
        email: json['email'] as String? ?? '',
        username: json['username'] as String? ?? '',
        image: json['image'] as String? ?? '',
      );

  factory UserModel.fromStorage({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String image,
  }) =>
      UserModel(
        id: int.tryParse(id) ?? 0,
        firstName: firstName,
        lastName: lastName,
        email: email,
        username: '',
        image: image,
      );
}
