class LoginModel {
  String accessToken;
  String refreshToken;

  LoginModel({required this.accessToken, required this.refreshToken});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
  );
}
