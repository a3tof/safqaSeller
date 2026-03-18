class AuthResponseModel {
  final bool isSuccess;
  final String? message;
  final String? userId;
  final String? token;
  final String? refreshToken;

  AuthResponseModel({
    required this.isSuccess,
    this.message,
    this.userId,
    this.token,
    this.refreshToken,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      // API returns both "IsSuccess" and "isSuccess" depending on the endpoint
      isSuccess: (json['IsSuccess'] ?? json['isSuccess'] ?? false) as bool,
      message: (json['Message'] ?? json['message']) as String?,
      userId: (json['UserId'] ?? json['userId']) as String?,
      token: (json['Token'] ?? json['token']) as String?,
      refreshToken:
          (json['RefreshToken'] ?? json['refreshToken']) as String?,
    );
  }
}
