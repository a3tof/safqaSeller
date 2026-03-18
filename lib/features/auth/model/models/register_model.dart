class RegisterRequestModel {
  final String fullName;
  final int gender;
  final String birthDate;
  final int cityId;
  final String phoneNumber;
  final String email;
  final String password;

  RegisterRequestModel({
    required this.fullName,
    required this.gender,
    required this.birthDate,
    required this.cityId,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'gender': gender,
        'birthDate': birthDate,
        'cityId': cityId,
        'phoneNumber': phoneNumber,
        'email': email,
        'password': password,
      };
}
