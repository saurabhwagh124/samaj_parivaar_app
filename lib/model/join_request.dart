class JoinRequest {
  JoinRequest({
    required this.requestId,
    required this.groupId,
    required this.userId,
    required this.requestMessage,
    required this.status,
    required this.reviewedBy,
    required this.reviewMessage,
    required this.requestedAt,
    required this.reviewedAt,
    required this.user,
  });

  final num? requestId;
  final num? groupId;
  final num? userId;
  final dynamic requestMessage;
  final String? status;
  final num? reviewedBy;
  final dynamic reviewMessage;
  final DateTime? requestedAt;
  final dynamic reviewedAt;
  final User? user;

  JoinRequest copyWith({
    num? requestId,
    num? groupId,
    num? userId,
    String? requestMessage,
    String? status,
    num? reviewedBy,
    String? reviewMessage,
    DateTime? requestedAt,
    DateTime? reviewedAt,
    User? user,
  }) {
    return JoinRequest(
      requestId: requestId ?? this.requestId,
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
      requestMessage: requestMessage ?? this.requestMessage,
      status: status ?? this.status,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      reviewMessage: reviewMessage ?? this.reviewMessage,
      requestedAt: requestedAt ?? this.requestedAt,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      user: user ?? this.user,
    );
  }

  factory JoinRequest.fromJson(Map<String, dynamic> json) {
    return JoinRequest(
      requestId: json["requestId"],
      groupId: json["groupId"],
      userId: json["userId"],
      requestMessage: json["requestMessage"],
      status: json["status"],
      reviewedBy: json["reviewedBy"],
      reviewMessage: json["reviewMessage"],
      requestedAt: DateTime.tryParse(json["requestedAt"] ?? ""),
      reviewedAt: DateTime.tryParse(json["reviewedAt"] ?? ""),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "groupId": groupId,
    "userId": userId,
    "requestMessage": requestMessage,
    "status": status,
    "reviewedBy": reviewedBy,
    "reviewMessage": reviewMessage,
    "requestedAt": requestedAt?.toIso8601String(),
    "reviewedAt": reviewedAt?.toIso8601String(),
    "user": user?.toJson(),
  };

  @override
  String toString() {
    return "$requestId, $groupId, $userId, $requestMessage, $status, $reviewedBy, $reviewMessage, $requestedAt, $reviewedAt, $user, ";
  }
}

class User {
  User({
    required this.id,
    required this.fullName,
    required this.profilePhotoUrl,
  });

  final int? id;
  final String? fullName;
  final dynamic profilePhotoUrl;

  User copyWith({int? id, String? fullName, String? profilePhotoUrl}) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      fullName: json["fullName"],
      profilePhotoUrl: json["profilePhotoUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "profilePhotoUrl": profilePhotoUrl,
  };

  @override
  String toString() {
    return "$id, $fullName, $profilePhotoUrl, ";
  }
}
