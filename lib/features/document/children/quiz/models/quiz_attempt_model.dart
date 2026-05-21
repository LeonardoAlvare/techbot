import 'dart:convert';

QuizAttemptModel quizAttemptModelFromJson(String str) =>
    QuizAttemptModel.fromJson(json.decode(str));

String quizAttemptModelToJson(QuizAttemptModel data) =>
    json.encode(data.toJson());

class QuizAttemptModel {
  final List<Answer>? answers;
  final int? timeTaken;

  QuizAttemptModel({this.answers, this.timeTaken});

  QuizAttemptModel copyWith({List<Answer>? answers, int? timeTaken}) =>
      QuizAttemptModel(
        answers: answers ?? this.answers,
        timeTaken: timeTaken ?? this.timeTaken,
      );

  factory QuizAttemptModel.fromJson(Map<String, dynamic> json) =>
      QuizAttemptModel(
        answers: json["answers"] == null
            ? []
            : List<Answer>.from(
                json["answers"]!.map((x) => Answer.fromJson(x)),
              ),
        timeTaken: json["timeTaken"],
      );

  Map<String, dynamic> toJson() => {
    "answers": answers == null
        ? []
        : List<dynamic>.from(answers!.map((x) => x.toJson())),
    "timeTaken": timeTaken,
  };
}

class Answer {
  final int? questionId;
  final String? selectedOption;

  Answer({this.questionId, this.selectedOption});

  Answer copyWith({int? questionId, String? selectedOption}) => Answer(
    questionId: questionId ?? this.questionId,
    selectedOption: selectedOption ?? this.selectedOption,
  );

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    questionId: json["questionId"],
    selectedOption: json["selectedOption"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "selectedOption": selectedOption,
  };
}
