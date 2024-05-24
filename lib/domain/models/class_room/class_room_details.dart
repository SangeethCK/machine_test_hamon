class ClassRoomDetailResponse {
  int? id;
  final String? layout;
  String? name;
  final int? size;
  var subject;
  String? subjectName;

  ClassRoomDetailResponse({
    this.id,
    this.layout,
    this.name,
    this.size,
    this.subject,
    this.subjectName,
  });

  ClassRoomDetailResponse copyWith({
    int? id,
    String? layout,
    String? name,
    int? size,
    var subject,
    String? subjectName,
  }) =>
      ClassRoomDetailResponse(
          id: id ?? this.id,
          layout: layout ?? this.layout,
          name: name ?? this.name,
          size: size ?? this.size,
          subject: subject ?? this.subject,
          subjectName: subjectName ?? this.subjectName);

  factory ClassRoomDetailResponse.fromJson(Map<String, dynamic> json) =>
      ClassRoomDetailResponse(
          id: json["id"],
          layout: json["layout"],
          name: json["name"],
          size: json["size"],
          subject: json["subject"].toString(),
          subjectName: json["subject_name"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "layout": layout,
        "name": name,
        "size": size,
        "subject": subject,
        "subject_name": subjectName
      };
}
