class ClassRoomResponse {
  final List<Classroom>? classrooms;

  ClassRoomResponse({
    this.classrooms,
  });

  ClassRoomResponse copyWith({
    List<Classroom>? classrooms,
  }) =>
      ClassRoomResponse(
        classrooms: classrooms ?? this.classrooms,
      );

  factory ClassRoomResponse.fromJson(Map<String, dynamic> json) =>
      ClassRoomResponse(
        classrooms: json["classrooms"] == null
            ? []
            : List<Classroom>.from(
                json["classrooms"]!.map((x) => Classroom.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "classrooms": classrooms == null
            ? []
            : List<dynamic>.from(classrooms!.map((x) => x.toJson())),
      };
}

class Classroom {
  final int? id;
  final String? layout;
  final String? name;
  final int? size;

  Classroom({
    this.id,
    this.layout,
    this.name,
    this.size,
  });

  Classroom copyWith({
    int? id,
    String? layout,
    String? name,
    int? size,
  }) =>
      Classroom(
        id: id ?? this.id,
        layout: layout ?? this.layout,
        name: name ?? this.name,
        size: size ?? this.size,
      );

  factory Classroom.fromJson(Map<String, dynamic> json) => Classroom(
        id: json["id"],
        layout: json["layout"],
        name: json["name"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "layout": layout,
        "name": name,
        "size": size,
      };
}
