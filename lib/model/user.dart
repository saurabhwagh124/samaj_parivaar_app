class User {
  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
    required this.profilePhotoUrl,
    required this.bio,
    required this.locationArea,
    required this.isSuperAdmin,
    required this.upiId,
    required this.emailVerified,
    required this.createdAt,
  });

  final int? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final DateTime? birthDate;
  final String? profilePhotoUrl;
  final String? bio;
  final String? locationArea;
  final bool? isSuperAdmin;
  final String? upiId;
  final bool? emailVerified;
  final DateTime? createdAt;

  User copyWith({
    int? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    DateTime? birthDate,
    String? profilePhotoUrl,
    String? bio,
    String? locationArea,
    bool? isSuperAdmin,
    String? upiId,
    bool? emailVerified,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDate: birthDate ?? this.birthDate,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      bio: bio ?? this.bio,
      locationArea: locationArea ?? this.locationArea,
      isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
      upiId: upiId ?? this.upiId,
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
      birthDate: DateTime.tryParse(json["birthDate"] ?? ""),
      profilePhotoUrl: json["profilePhotoUrl"],
      bio: json["bio"],
      locationArea: json["locationArea"],
      isSuperAdmin: json["isSuperAdmin"],
      upiId: json["upiId"],
      emailVerified: json["emailVerified"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "phoneNumber": phoneNumber,
    "birthDate":
        "${birthDate?.year.toString().padLeft(4, '0')}-${birthDate?.month.toString().padLeft(2, '0')}-${birthDate?.day.toString().padLeft(2, '0')}",
    "profilePhotoUrl": profilePhotoUrl,
    "bio": bio,
    "locationArea": locationArea,
    "isSuperAdmin": isSuperAdmin,
    "upiId": upiId,
    "emailVerified": emailVerified,
    "createdAt": createdAt?.toIso8601String(),
  };

  @override
  String toString() {
    return "$id, $fullName, $email, $phoneNumber, $birthDate, $profilePhotoUrl, $bio, $locationArea, $isSuperAdmin, $upiId, $emailVerified, $createdAt, ";
  }
}
