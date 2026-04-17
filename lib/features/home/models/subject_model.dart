class SubjectModel {
  final int? id;
  final String? name;
  final String? description;
  final Count? count;

  SubjectModel({this.id, this.name, this.description, this.count});

  SubjectModel copyWith({
    int? id,
    String? name,
    String? description,
    Count? count,
  }) => SubjectModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    count: count ?? this.count,
  );

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "_count": count?.toJson(),
  };
}

class Count {
  final int? documents;

  Count({this.documents});

  Count copyWith({int? documents}) =>
      Count(documents: documents ?? this.documents);

  factory Count.fromJson(Map<String, dynamic> json) =>
      Count(documents: json["documents"]);

  Map<String, dynamic> toJson() => {"documents": documents};
}
