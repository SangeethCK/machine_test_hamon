class UpdateSubjectRequest {
  int? id;
  String? layout;
  String? name;
  int? size;
  int? subject;

  UpdateSubjectRequest({
    this.id,
    this.layout,
    this.name,
    this.size,
    this.subject,
  });

  UpdateSubjectRequest copyWith({
    int? id,
    String? layout,
    String? name,
    int? size,
    int? subject,
  }) =>
      UpdateSubjectRequest(
        id: id ?? this.id,
        layout: layout ?? this.layout,
        name: name ?? this.name,
        size: size ?? this.size,
        subject: subject ?? this.subject,
      );

  factory UpdateSubjectRequest.fromJson(Map<String, dynamic> json) =>
      UpdateSubjectRequest(
        id: json["id"],
        layout: json["layout"],
        name: json["name"],
        size: json["size"],
        subject: json["subject"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "layout": layout,
        "name": name,
        "size": size,
        "subject": subject,
      };
}
