class StudentDetailResponse {
  final int? age;
  final String? email;
  final int? id;
  final String? name;

  StudentDetailResponse({
    this.age,
    this.email,
    this.id,
    this.name,
  });

  StudentDetailResponse copyWith({
    int? age,
    String? email,
    int? id,
    String? name,
  }) =>
      StudentDetailResponse(
        age: age ?? this.age,
        email: email ?? this.email,
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory StudentDetailResponse.fromJson(Map<String, dynamic> json) =>
      StudentDetailResponse(
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
