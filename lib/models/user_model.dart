class UserModel {
  final int? id;
  final String name;
  final String email;
  final String? gender;

  UserModel({
     this.id,
    required this.name,
    required this.email,
    this.gender,
  });

  UserModel.fromJson(Map<dynamic, dynamic> json)
      : id = int.tryParse(json['id']?.toString() ?? '') ?? 0,
        name = json['name']?.toString() ?? '',
        email = json['email']?.toString() ?? '',
        gender = json['gender']?.toString();

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'email': email, 'gender': gender};

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? gender,
  }) =>
      UserModel(
          id: id ?? this.id,
          name: name ?? this.name,
          email: email ?? this.email,
          gender: gender ?? this.gender);

  @override
  String toString() {
    return 'id : $id'
        'name : $name'
        'email : $email'
        'gender : $gender';
  }
}
