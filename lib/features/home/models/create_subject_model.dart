class CreateSubjectModel {
  final int? id;
  final String? name;
  final String? description;
  final int? userId;

  CreateSubjectModel({this.id, this.name, this.description, this.userId});

  CreateSubjectModel copyWith({
    int? id,
    String? name,
    String? description,
    int? userId,
  }) => CreateSubjectModel(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    userId: userId ?? this.userId,
  );

  factory CreateSubjectModel.fromJson(Map<String, dynamic> json) =>
      CreateSubjectModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "user_id": userId,
  };
}
