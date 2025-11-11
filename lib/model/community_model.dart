class CommunityModel {
  CommunityModel({
    required this.groupId,
    required this.groupName,
    required this.groupDescription,
    required this.locationArea,
    required this.memberCount,
    required this.coverPhotoUrl,
    required this.groupRules,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.creator,
  });

  final num? groupId;
  final String? groupName;
  final String? groupDescription;
  final String? locationArea;
  final num? memberCount;
  final String? coverPhotoUrl;
  final String? groupRules;
  final num? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Creator? creator;

  CommunityModel copyWith({
    num? groupId,
    String? groupName,
    String? groupDescription,
    String? locationArea,
    num? memberCount,
    String? coverPhotoUrl,
    String? groupRules,
    num? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    Creator? creator,
  }) {
    return CommunityModel(
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      groupDescription: groupDescription ?? this.groupDescription,
      locationArea: locationArea ?? this.locationArea,
      memberCount: memberCount ?? this.memberCount,
      coverPhotoUrl: coverPhotoUrl ?? this.coverPhotoUrl,
      groupRules: groupRules ?? this.groupRules,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      creator: creator ?? this.creator,
    );
  }

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      groupId: json["groupId"],
      groupName: json["groupName"],
      groupDescription: json["groupDescription"],
      locationArea: json["locationArea"],
      memberCount: json["memberCount"],
      coverPhotoUrl: json["coverPhotoUrl"],
      groupRules: json["groupRules"],
      createdBy: json["createdBy"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      creator: json["creator"] == null
          ? null
          : Creator.fromJson(json["creator"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "groupId": groupId,
    "groupName": groupName,
    "groupDescription": groupDescription,
    "locationArea": locationArea,
    "memberCount": memberCount,
    "coverPhotoUrl": coverPhotoUrl,
    "groupRules": groupRules,
    "createdBy": createdBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "creator": creator?.toJson(),
  };

  @override
  String toString() {
    return "$groupId, $groupName, $groupDescription, $locationArea, $memberCount, $coverPhotoUrl, $groupRules, $createdBy, $createdAt, $updatedAt, $creator, ";
  }
}

class Creator {
  Creator({required this.id, required this.fullName});

  final int? id;
  final String? fullName;

  Creator copyWith({int? id, String? fullName}) {
    return Creator(id: id ?? this.id, fullName: fullName ?? this.fullName);
  }

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(id: json["id"], fullName: json["fullName"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "fullName": fullName};

  @override
  String toString() {
    return "$id, $fullName, ";
  }
}
