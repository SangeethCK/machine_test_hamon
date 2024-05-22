class SubjectDetailResponse {
  final int? credits;
  final int? id;
  final String? name;
  final String? teacher;

  SubjectDetailResponse({
    this.credits,
    this.id,
    this.name,
    this.teacher,
  });

  SubjectDetailResponse copyWith({
    int? credits,
    int? id,
    String? name,
    String? teacher,
  }) =>
      SubjectDetailResponse(
        credits: credits ?? this.credits,
        id: id ?? this.id,
        name: name ?? this.name,
        teacher: teacher ?? this.teacher,
      );

  factory SubjectDetailResponse.fromJson(Map<String, dynamic> json) =>
      SubjectDetailResponse(
        credits: json["credits"],
        id: json["id"],
        name: json["name"],
        teacher: json["teacher"],
      );

  Map<String, dynamic> toJson() => {
        "credits": credits,
        "id": id,
        "name": name,
        "teacher": teacher,
      };
}
