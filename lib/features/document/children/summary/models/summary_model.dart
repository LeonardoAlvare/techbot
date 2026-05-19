import 'dart:convert';

SummaryModel summaryModelFromJson(String str) =>
    SummaryModel.fromJson(json.decode(str));

String summaryModelToJson(SummaryModel data) => json.encode(data.toJson());

class SummaryModel {
  final int? id;
  final String? content;
  final int? documentId;

  SummaryModel({this.id, this.content, this.documentId});

  SummaryModel copyWith({int? id, String? content, int? documentId}) =>
      SummaryModel(
        id: id ?? this.id,
        content: content ?? this.content,
        documentId: documentId ?? this.documentId,
      );

  factory SummaryModel.fromJson(Map<String, dynamic> json) => SummaryModel(
    id: json["id"],
    content: json["content"],
    documentId: json["document_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "document_id": documentId,
  };
}
