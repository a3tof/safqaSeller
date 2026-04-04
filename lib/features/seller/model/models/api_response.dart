class ApiResponse {
  final bool isSuccess;
  final String? message;
  final List<String> errors;

  ApiResponse({
    required this.isSuccess,
    this.message,
    this.errors = const [],
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      isSuccess: (json['isSuccess'] ?? json['IsSuccess'] ?? false) as bool,
      message: (json['message'] ?? json['Message']) as String?,
      errors: _parseErrors(json['errors'] ?? json['Errors']),
    );
  }

  static List<String> _parseErrors(dynamic errors) {
    if (errors is List) {
      return errors.map((e) => e.toString()).toList();
    }
    return [];
  }
}
