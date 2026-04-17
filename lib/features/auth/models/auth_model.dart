class AuthModel {
  final String accessToken;

  AuthModel({required this.accessToken});

  AuthModel copyWith({String? accessToken}) =>
      AuthModel(accessToken: accessToken ?? this.accessToken);

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      AuthModel(accessToken: json["accessToken"]);

  Map<String, dynamic> toJson() => {"accessToken": accessToken};
}
