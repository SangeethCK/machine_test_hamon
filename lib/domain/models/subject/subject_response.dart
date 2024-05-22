class SubjectResponse {
  final List<SubjectList>? subjects;

  SubjectResponse({
    this.subjects,
  });

  SubjectResponse copyWith({
    List<SubjectList>? subjects,
  }) =>
      SubjectResponse(
        subjects: subjects ?? this.subjects,
      );

  factory SubjectResponse.fromJson(Map<String, dynamic> json) =>
      SubjectResponse(
        subjects: json["subjects"] == null
            ? []
            : List<SubjectList>.from(
                json["subjects"]!.map((x) => SubjectList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subjects": subjects == null
            ? []
            : List<dynamic>.from(subjects!.map((x) => x.toJson())),
      };
}

class SubjectList {
  final int? credits;
  final int? id;
  final String? name;
  final String? teacher;

  SubjectList({
    this.credits,
    this.id,
    this.name,
    this.teacher,
  });

  SubjectList copyWith({
    int? credits,
    int? id,
    String? name,
    String? teacher,
  }) =>
      SubjectList(
        credits: credits ?? this.credits,
        id: id ?? this.id,
        name: name ?? this.name,
        teacher: teacher ?? this.teacher,
      );

  factory SubjectList.fromJson(Map<String, dynamic> json) => SubjectList(
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
