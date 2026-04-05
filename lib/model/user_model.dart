class FullName {
  final String firstName;
  final String lastName;

  FullName({required this.firstName, required this.lastName});

  String get fullNameText => "$firstName $lastName";

  Map<String, dynamic> toMap() {
    return {'firstName': firstName, 'lastName': lastName};
  }

  factory FullName.fromMap(Map<String, dynamic> map) {
    return FullName(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
    );
  }
}

class UserModel {
  //  final String id;
  final FullName fullName;
  final String email;
  final String phone;
  final String profileImage;
  final DateTime birthDate;
  final String password; // ✅ الجديد
  final String role; // ✅ الجديد

  UserModel({
    // required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.birthDate,
    required this.password,
    required this.role,
  });

  /// Getters

  String get firstName => fullName.firstName;

  String get lastName => fullName.lastName;

  String get fullNameText => fullName.fullNameText;

  int get age {
    final now = DateTime.now();
    int years = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      years--;
    }

    return years;
  }

  /// تحويل لـ Map

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'fullName': fullName.toMap(),
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'birthDate': birthDate.toIso8601String(),
      'password': password, // ✅ أضيف
      'role': role, // ✅ أضيف
    };
  }

  /// إنشاء من Map

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      //id: map['id'] ?? '',
      fullName: FullName.fromMap(map['fullName'] ?? {}),
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      profileImage: map['profileImage'] ?? '',
      birthDate: DateTime.parse(
        map['birthDate'] ?? DateTime.now().toIso8601String(),
      ),
      password: map['password'] ?? '',
      role: map['role'] ?? '',
    );
  }

  /// copyWith

  UserModel copyWith({
    // String? id,
    FullName? fullName,
    String? email,
    String? phone,
    String? profileImage,
    DateTime? birthDate,
    String? password,
    String? role,
  }) {
    return UserModel(
      //  id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      birthDate: birthDate ?? this.birthDate,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  @override
  String toString() {
    return 'UserModel{ fullName: $fullName, email: $email, phone: $phone, profileImage: $profileImage, birthDate: $birthDate, password: $password, role: $role}';
  }
}
