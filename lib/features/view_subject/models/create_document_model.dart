import 'dart:convert';

CreateDocumentModel createDocumentModelFromJson(String str) =>
    CreateDocumentModel.fromJson(json.decode(str));

String createDocumentModelToJson(CreateDocumentModel data) =>
    json.encode(data.toJson());

class CreateDocumentModel {
  final String? message;
  final Document? document;

  CreateDocumentModel({this.message, this.document});

  CreateDocumentModel copyWith({String? message, Document? document}) =>
      CreateDocumentModel(
        message: message ?? this.message,
        document: document ?? this.document,
      );

  factory CreateDocumentModel.fromJson(Map<String, dynamic> json) =>
      CreateDocumentModel(
        message: json["message"],
        document: json["document"] == null
            ? null
            : Document.fromJson(json["document"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "document": document?.toJson(),
  };
}

class Document {
  final int? id;
  final String? title;
  final String? filename;

  Document({this.id, this.title, this.filename});

  Document copyWith({int? id, String? title, String? filename}) => Document(
    id: id ?? this.id,
    title: title ?? this.title,
    filename: filename ?? this.filename,
  );

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    id: json["id"],
    title: json["title"],
    filename: json["filename"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "filename": filename,
  };
}
