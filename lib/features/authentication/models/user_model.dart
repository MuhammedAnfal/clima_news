class UserModel {
  String id;
  String fullName;
  String email;
  String password;
  String profilePicture;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.profilePicture,
  });

  // Factory method for creating a UserModel from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
    );
  }

  // Method for converting a UserModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
    };
  }

  // CopyWith method for immutability
  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? password,
    String? profilePicture,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: email ?? this.password,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  //-- static function to split full name into first name and last name
  static List<String> nameParts(fullName) => fullName.split(' ');

  //--static function to create an empty model
  static UserModel empty() => UserModel(
    id: '',
    fullName: '',
    email: '',
    password: '',
    profilePicture: '',
  );
}
