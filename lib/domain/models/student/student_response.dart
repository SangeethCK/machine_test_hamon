class StudentsResponse {
  final List<StudentList>? students;

  StudentsResponse({
    this.students,
  });

  StudentsResponse copyWith({
    List<StudentList>? students,
  }) =>
      StudentsResponse(
        students: students ?? this.students,
      );

  factory StudentsResponse.fromJson(Map<String, dynamic> json) =>
      StudentsResponse(
        students: json["students"] == null
            ? []
            : List<StudentList>.from(
                json["students"]!.map((x) => StudentList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "students": students == null
            ? []
            : List<dynamic>.from(students!.map((x) => x.toJson())),
      };
}

class StudentList {
  final int? age;
  final String? email;
  final int? id;
  final String? name;

  StudentList({
    this.age,
    this.email,
    this.id,
    this.name,
  });

  StudentList copyWith({
    int? age,
    String? email,
    int? id,
    String? name,
  }) =>
      StudentList(
        age: age ?? this.age,
        email: email ?? this.email,
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
        age: json["age"],
        email: json["email"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "age": age,
        "email": email,
        "id": id,
        "name": name,
      };
}
