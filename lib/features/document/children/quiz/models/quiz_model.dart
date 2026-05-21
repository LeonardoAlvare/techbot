import 'dart:convert';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  final int? id;
  final String? title;
  final int? documentId;
  final List<Question>? questions;

  QuizModel({this.id, this.title, this.documentId, this.questions});

  QuizModel copyWith({
    int? id,
    String? title,
    int? documentId,
    List<Question>? questions,
  }) => QuizModel(
    id: id ?? this.id,
    title: title ?? this.title,
    documentId: documentId ?? this.documentId,
    questions: questions ?? this.questions,
  );

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    id: json["id"],
    title: json["title"],
    documentId: json["document_id"],
    questions: json["questions"] == null
        ? []
        : List<Question>.from(
            json["questions"]!.map((x) => Question.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "document_id": documentId,
    "questions": questions == null
        ? []
        : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

class Question {
  final int? id;
  final String? questionText;
  final String? correctOption;
  final int? quizId;
  final List<Option>? options;

  Question({
    this.id,
    this.questionText,
    this.correctOption,
    this.quizId,
    this.options,
  });

  Question copyWith({
    int? id,
    String? questionText,
    String? correctOption,
    int? quizId,
    List<Option>? options,
  }) => Question(
    id: id ?? this.id,
    questionText: questionText ?? this.questionText,
    correctOption: correctOption ?? this.correctOption,
    quizId: quizId ?? this.quizId,
    options: options ?? this.options,
  );

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    questionText: json["question_text"],
    correctOption: json["correct_option"],
    quizId: json["quiz_id"],
    options: json["options"] == null
        ? []
        : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_text": questionText,
    "correct_option": correctOption,
    "quiz_id": quizId,
    "options": options == null
        ? []
        : List<dynamic>.from(options!.map((x) => x.toJson())),
  };
}

class Option {
  final int? id;
  final String? optionText;
  final int? questionId;

  Option({this.id, this.optionText, this.questionId});

  Option copyWith({int? id, String? optionText, int? questionId}) => Option(
    id: id ?? this.id,
    optionText: optionText ?? this.optionText,
    questionId: questionId ?? this.questionId,
  );

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    optionText: json["option_text"],
    questionId: json["question_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "option_text": optionText,
    "question_id": questionId,
  };
}
