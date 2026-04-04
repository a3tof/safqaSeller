import 'dart:convert';
import 'dart:typed_data';

class SellerHomeResponse {
  final String storeName;
  final String? storeLogo;

  SellerHomeResponse({
    required this.storeName,
    this.storeLogo,
  });

  factory SellerHomeResponse.fromJson(Map<String, dynamic> json) {
    return SellerHomeResponse(
      storeName: (json['storeName'] ?? json['StoreName'] ?? '') as String,
      storeLogo: (json['storeLogo'] ?? json['StoreLogo']) as String?,
    );
  }

  /// Decodes the base64 logo string into bytes for display.
  Uint8List? get logoBytes {
    if (storeLogo == null || storeLogo!.isEmpty) return null;
    try {
      return base64Decode(storeLogo!);
    } catch (_) {
      return null;
    }
  }
}
