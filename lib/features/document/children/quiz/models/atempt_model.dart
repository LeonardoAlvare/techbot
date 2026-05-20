import 'dart:convert';

AttemptModel attemptModelFromJson(String str) =>
    AttemptModel.fromJson(json.decode(str));

String attemptModelToJson(AttemptModel data) => json.encode(data.toJson());

class AttemptModel {
  final int? score;
  final int? correctAnswers;
  final int? totalQuestions;
  final int? timeTaken;
  final List<Answer>? answers;

  AttemptModel({
    this.score,
    this.correctAnswers,
    this.totalQuestions,
    this.timeTaken,
    this.answers,
  });

  AttemptModel copyWith({
    int? score,
    int? correctAnswers,
    int? totalQuestions,
    int? timeTaken,
    List<Answer>? answers,
  }) => AttemptModel(
    score: score ?? this.score,
    correctAnswers: correctAnswers ?? this.correctAnswers,
    totalQuestions: totalQuestions ?? this.totalQuestions,
    timeTaken: timeTaken ?? this.timeTaken,
    answers: answers ?? this.answers,
  );

  factory AttemptModel.fromJson(Map<String, dynamic> json) => AttemptModel(
    score: json["score"],
    correctAnswers: json["correctAnswers"],
    totalQuestions: json["totalQuestions"],
    timeTaken: json["timeTaken"],
    answers: json["answers"] == null
        ? []
        : List<Answer>.from(json["answers"]!.map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "score": score,
    "correctAnswers": correctAnswers,
    "totalQuestions": totalQuestions,
    "timeTaken": timeTaken,
    "answers": answers == null
        ? []
        : List<dynamic>.from(answers!.map((x) => x.toJson())),
  };
}

class Answer {
  final int? id;
  final String? selectedOption;
  final bool? isCorrect;
  final int? attemptId;
  final int? questionId;

  Answer({
    this.id,
    this.selectedOption,
    this.isCorrect,
    this.attemptId,
    this.questionId,
  });

  Answer copyWith({
    int? id,
    String? selectedOption,
    bool? isCorrect,
    int? attemptId,
    int? questionId,
  }) => Answer(
    id: id ?? this.id,
    selectedOption: selectedOption ?? this.selectedOption,
    isCorrect: isCorrect ?? this.isCorrect,
    attemptId: attemptId ?? this.attemptId,
    questionId: questionId ?? this.questionId,
  );

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    id: json["id"],
    selectedOption: json["selected_option"],
    isCorrect: json["is_correct"],
    attemptId: json["attempt_id"],
    questionId: json["question_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "selected_option": selectedOption,
    "is_correct": isCorrect,
    "attempt_id": attemptId,
    "question_id": questionId,
  };
}
