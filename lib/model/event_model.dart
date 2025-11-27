class EventModel {
  EventModel({
    required this.eventId,
    required this.groupId,
    required this.createdBy,
    required this.eventTitle,
    required this.eventDescription,
    required this.interestedCount,
    required this.eventDate,
    required this.eventLocation,
    required this.eventAddress,
    required this.registrationFee,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.coverImageUrl,
    required this.eventStatus,
    required this.isPaid,
    required this.isCancellable,
    required this.cancellationRefundPolicy,
    required this.upiId,
    required this.eventInterested,
    required this.showInterested,
    required this.createdAt,
    required this.updatedAt,
    required this.group,
    required this.creator,
  });

  final num? eventId;
  final num? groupId;
  final num? createdBy;
  final String? eventTitle;
  final String? eventDescription;
  final num? interestedCount;
  final DateTime? eventDate;
  final String? eventLocation;
  final String? eventAddress;
  final dynamic registrationFee;
  final num? maxParticipants;
  final num? currentParticipants;
  final String? coverImageUrl;
  final String? eventStatus;
  final bool? isPaid;
  final bool? isCancellable;
  final dynamic cancellationRefundPolicy;
  final dynamic upiId;
  final num? eventInterested;
  final bool? showInterested;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Group? group;
  final Creator? creator;

  EventModel copyWith({
    num? eventId,
    num? groupId,
    num? createdBy,
    String? eventTitle,
    String? eventDescription,
    num? interestedCount,
    DateTime? eventDate,
    String? eventLocation,
    String? eventAddress,
    int? registrationFee,
    num? maxParticipants,
    num? currentParticipants,
    String? coverImageUrl,
    String? eventStatus,
    bool? isPaid,
    bool? isCancellable,
    String? cancellationRefundPolicy,
    String? upiId,
    num? eventInterested,
    bool? showInterested,
    DateTime? createdAt,
    DateTime? updatedAt,
    Group? group,
    Creator? creator,
  }) {
    return EventModel(
      eventId: eventId ?? this.eventId,
      groupId: groupId ?? this.groupId,
      createdBy: createdBy ?? this.createdBy,
      eventTitle: eventTitle ?? this.eventTitle,
      eventDescription: eventDescription ?? this.eventDescription,
      interestedCount: interestedCount ?? this.interestedCount,
      eventDate: eventDate ?? this.eventDate,
      eventLocation: eventLocation ?? this.eventLocation,
      eventAddress: eventAddress ?? this.eventAddress,
      registrationFee: registrationFee ?? this.registrationFee,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      currentParticipants: currentParticipants ?? this.currentParticipants,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      eventStatus: eventStatus ?? this.eventStatus,
      isPaid: isPaid ?? this.isPaid,
      isCancellable: isCancellable ?? this.isCancellable,
      cancellationRefundPolicy:
          cancellationRefundPolicy ?? this.cancellationRefundPolicy,
      upiId: upiId ?? this.upiId,
      eventInterested: eventInterested ?? this.eventInterested,
      showInterested: showInterested ?? this.showInterested,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      group: group ?? this.group,
      creator: creator ?? this.creator,
    );
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json["eventId"],
      groupId: json["groupId"],
      createdBy: json["createdBy"],
      eventTitle: json["eventTitle"],
      eventDescription: json["eventDescription"],
      interestedCount: json["interestedCount"],
      eventDate: DateTime.tryParse(json["eventDate"] ?? ""),
      eventLocation: json["eventLocation"],
      eventAddress: json["eventAddress"],
      registrationFee: json["registrationFee"],
      maxParticipants: json["maxParticipants"],
      currentParticipants: json["currentParticipants"],
      coverImageUrl: json["coverImageUrl"],
      eventStatus: json["eventStatus"],
      isPaid: json["isPaid"],
      isCancellable: json["isCancellable"],
      cancellationRefundPolicy: json["cancellationRefundPolicy"],
      upiId: json["upiId"],
      eventInterested: json["eventInterested"],
      showInterested: json["showInterested"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      group: json["group"] == null ? null : Group.fromJson(json["group"]),
      creator: json["creator"] == null
          ? null
          : Creator.fromJson(json["creator"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "eventId": eventId,
    "groupId": groupId,
    "createdBy": createdBy,
    "eventTitle": eventTitle,
    "eventDescription": eventDescription,
    "interestedCount": interestedCount,
    "eventDate": eventDate?.toIso8601String(),
    "eventLocation": eventLocation,
    "eventAddress": eventAddress,
    "registrationFee": registrationFee,
    "maxParticipants": maxParticipants,
    "currentParticipants": currentParticipants,
    "coverImageUrl": coverImageUrl,
    "eventStatus": eventStatus,
    "isPaid": isPaid,
    "isCancellable": isCancellable,
    "cancellationRefundPolicy": cancellationRefundPolicy,
    "upiId": upiId,
    "eventInterested": eventInterested,
    "showInterested": showInterested,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "group": group?.toJson(),
    "creator": creator?.toJson(),
  };

  @override
  String toString() {
    return "$eventId, $groupId, $createdBy, $eventTitle, $eventDescription, $interestedCount, $eventDate, $eventLocation, $eventAddress, $registrationFee, $maxParticipants, $currentParticipants, $coverImageUrl, $eventStatus, $isPaid, $isCancellable, $cancellationRefundPolicy, $upiId, $eventInterested, $showInterested, $createdAt, $updatedAt, $group, $creator, ";
  }
}

class Creator {
  Creator({
    required this.id,
    required this.fullName,
    required this.profilePhotoUrl,
    required this.email,
  });

  final int? id;
  final String? fullName;
  final String? profilePhotoUrl;
  final String? email;

  Creator copyWith({
    int? id,
    String? fullName,
    String? profilePhotoUrl,
    String? email,
  }) {
    return Creator(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      email: email ?? this.email,
    );
  }

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json["id"],
      fullName: json["fullName"],
      profilePhotoUrl: json["profilePhotoUrl"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "profilePhotoUrl": profilePhotoUrl,
    "email": email,
  };

  @override
  String toString() {
    return "$id, $fullName, $profilePhotoUrl, $email, ";
  }
}

class Group {
  Group({
    required this.groupId,
    required this.groupName,
    required this.coverPhotoUrl,
  });

  final num? groupId;
  final String? groupName;
  final String? coverPhotoUrl;

  Group copyWith({num? groupId, String? groupName, String? coverPhotoUrl}) {
    return Group(
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      coverPhotoUrl: coverPhotoUrl ?? this.coverPhotoUrl,
    );
  }

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json["groupId"],
      groupName: json["groupName"],
      coverPhotoUrl: json["coverPhotoUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
    "groupId": groupId,
    "groupName": groupName,
    "coverPhotoUrl": coverPhotoUrl,
  };

  @override
  String toString() {
    return "$groupId, $groupName, $coverPhotoUrl, ";
  }
}
