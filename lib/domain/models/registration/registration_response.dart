class RegistrationResponse {
  final Registration? registration;

  RegistrationResponse({
    this.registration,
  });

  RegistrationResponse copyWith({
    Registration? registration,
  }) =>
      RegistrationResponse(
        registration: registration ?? this.registration,
      );

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationResponse(
        registration: json["registration"] == null
            ? null
            : Registration.fromJson(json["registration"]),
      );

  Map<String, dynamic> toJson() => {
        "registration": registration?.toJson(),
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
