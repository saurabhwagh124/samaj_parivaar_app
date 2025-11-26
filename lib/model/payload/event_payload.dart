class EventPayload {
  EventPayload({
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
    required this.eventInterested,
    required this.showInterested,
  });

  final num? groupId;
  final num? createdBy;
  final String? eventTitle;
  final String? eventDescription;
  final num? interestedCount;
  final DateTime? eventDate;
  final String? eventLocation;
  final String? eventAddress;
  final String? registrationFee;
  final num? maxParticipants;
  final num? currentParticipants;
  final String? coverImageUrl;
  final String? eventStatus;
  final bool? isPaid;
  final bool? isCancellable;
  final num? eventInterested;
  final bool? showInterested;

  EventPayload copyWith({
    num? groupId,
    num? createdBy,
    String? eventTitle,
    String? eventDescription,
    num? interestedCount,
    DateTime? eventDate,
    String? eventLocation,
    String? eventAddress,
    String? registrationFee,
    num? maxParticipants,
    num? currentParticipants,
    String? coverImageUrl,
    String? eventStatus,
    bool? isPaid,
    bool? isCancellable,
    num? eventInterested,
    bool? showInterested,
  }) {
    return EventPayload(
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
      eventInterested: eventInterested ?? this.eventInterested,
      showInterested: showInterested ?? this.showInterested,
    );
  }

  factory EventPayload.fromJson(Map<String, dynamic> json) {
    return EventPayload(
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
      eventInterested: json["eventInterested"],
      showInterested: json["showInterested"],
    );
  }

  Map<String, dynamic> toJson() => {
    "groupId": groupId,
    "createdBy": createdBy,
    "eventTitle": eventTitle,
    "eventDescription": eventDescription,
    "interestedCount": interestedCount,
    "eventDate": eventDate?.toUtc().toIso8601String(),
    "eventLocation": eventLocation,
    "eventAddress": eventAddress,
    "registrationFee": registrationFee,
    "maxParticipants": maxParticipants,
    "currentParticipants": currentParticipants,
    "coverImageUrl": coverImageUrl,
    "eventStatus": eventStatus,
    "isPaid": isPaid,
    "isCancellable": isCancellable,
    "eventInterested": eventInterested,
    "showInterested": showInterested,
  };

  @override
  String toString() {
    return "$groupId, $createdBy, $eventTitle, $eventDescription, $interestedCount, $eventDate, $eventLocation, $eventAddress, $registrationFee, $maxParticipants, $currentParticipants, $coverImageUrl, $eventStatus, $isPaid, $isCancellable, $eventInterested, $showInterested, ";
  }
}
