class User {
  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.profilePhotoUrl,
    required this.bio,
    required this.locationArea,
    required this.isSuperAdmin,
    required this.emailVerified,
    required this.createdAt,
  });

  final num? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? profilePhotoUrl;
  final String? bio;
  final String? locationArea;
  final bool? isSuperAdmin;
  final bool? emailVerified;
  final DateTime? createdAt;

  User copyWith({
    num? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? profilePhotoUrl,
    String? bio,
    String? locationArea,
    bool? isSuperAdmin,
    bool? emailVerified,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      bio: bio ?? this.bio,
      locationArea: locationArea ?? this.locationArea,
      isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
      emailVerified: emailVerified ?? this.emailVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      profilePhotoUrl: json["profilePhotoUrl"],
      bio: json["bio"],
      locationArea: json["locationArea"],
      isSuperAdmin: json["isSuperAdmin"],
      emailVerified: json["emailVerified"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "phoneNumber": phoneNumber,
    "profilePhotoUrl": profilePhotoUrl,
    "bio": bio,
    "locationArea": locationArea,
    "isSuperAdmin": isSuperAdmin,
    "emailVerified": emailVerified,
    "createdAt": createdAt?.toIso8601String(),
  };

  @override
  String toString() {
    return "$id, $fullName, $email, $phoneNumber, $profilePhotoUrl, $bio, $locationArea, $isSuperAdmin, $emailVerified, $createdAt, ";
  }
}
