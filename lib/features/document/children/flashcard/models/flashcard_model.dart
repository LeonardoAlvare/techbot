import 'dart:convert';

FlashcardModel flashcardModelFromJson(String str) =>
    FlashcardModel.fromJson(json.decode(str));

String flashcardModelToJson(FlashcardModel data) => json.encode(data.toJson());

class FlashcardModel {
  final int? id;
  final String? question;
  final String? answer;
  final int? documentId;

  FlashcardModel({this.id, this.question, this.answer, this.documentId});

  FlashcardModel copyWith({
    int? id,
    String? question,
    String? answer,
    int? documentId,
  }) => FlashcardModel(
    id: id ?? this.id,
    question: question ?? this.question,
    answer: answer ?? this.answer,
    documentId: documentId ?? this.documentId,
  );

  factory FlashcardModel.fromJson(Map<String, dynamic> json) => FlashcardModel(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    documentId: json["document_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "document_id": documentId,
  };
}
