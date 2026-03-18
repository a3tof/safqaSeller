class GoogleAuthRequestModel {
  final String idToken;

  const GoogleAuthRequestModel({required this.idToken});

  Map<String, dynamic> toJson() => {'IdToken': idToken};
}

class FacebookAuthRequestModel {
  final String accessToken;

  const FacebookAuthRequestModel({required this.accessToken});

  Map<String, dynamic> toJson() => {'AccessToken': accessToken};
}

class RefreshTokenRequestModel {
  final String refreshToken;

  const RefreshTokenRequestModel({required this.refreshToken});

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}
