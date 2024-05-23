class RegistrationDetailsResponse {
  final int? id;
  final int? student;
  final int? subject;

  RegistrationDetailsResponse({
    this.id,
    this.student,
    this.subject,
  });

  RegistrationDetailsResponse copyWith({
    int? id,
    int? student,
    int? subject,
  }) =>
      RegistrationDetailsResponse(
        id: id ?? this.id,
        student: student ?? this.student,
        subject: subject ?? this.subject,
      );

  factory RegistrationDetailsResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationDetailsResponse(
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
