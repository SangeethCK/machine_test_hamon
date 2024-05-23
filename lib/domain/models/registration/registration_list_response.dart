class RegistrationListResponse {
  final List<Registration>? registrations;

  RegistrationListResponse({
    this.registrations,
  });

  RegistrationListResponse copyWith({
    List<Registration>? registrations,
  }) =>
      RegistrationListResponse(
        registrations: registrations ?? this.registrations,
      );

  factory RegistrationListResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationListResponse(
        registrations: json["registrations"] == null
            ? []
            : List<Registration>.from(
                json["registrations"]!.map((x) => Registration.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "registrations": registrations == null
            ? []
            : List<dynamic>.from(registrations!.map((x) => x.toJson())),
      };
}

class Registration {
  final int? id;
  final int? student;
  final int? subject;

  Registration({
    this.id,
    this.student,
    this.subject,
  });

  Registration copyWith({
    int? id,
    int? student,
    int? subject,
  }) =>
      Registration(
        id: id ?? this.id,
        student: student ?? this.student,
        subject: subject ?? this.subject,
      );

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        id: json["id"],
        student: json["student"],
        subject: json["subject"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student": student,
        "subject": subject,
      };
}
