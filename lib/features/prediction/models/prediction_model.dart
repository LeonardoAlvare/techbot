import 'dart:convert';

PredictionModel predictionModelFromJson(String str) =>
    PredictionModel.fromJson(json.decode(str));

String predictionModelToJson(PredictionModel data) =>
    json.encode(data.toJson());

class PredictionModel {
  final String? resultado;
  final double? confianza;
  final double? probabilidad;

  PredictionModel({this.resultado, this.confianza, this.probabilidad});

  PredictionModel copyWith({
    String? resultado,
    double? confianza,
    double? probabilidad,
  }) => PredictionModel(
    resultado: resultado ?? this.resultado,
    confianza: confianza ?? this.confianza,
    probabilidad: probabilidad ?? this.probabilidad,
  );

  factory PredictionModel.fromJson(Map<String, dynamic> json) =>
      PredictionModel(
        resultado: json["resultado"],
        confianza: json["confianza"]?.toDouble(),
        probabilidad: json["probabilidad"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "resultado": resultado,
    "confianza": confianza,
    "probabilidad": probabilidad,
  };
}
