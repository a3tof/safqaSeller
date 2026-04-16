import 'package:image_picker/image_picker.dart';

class CreateAuctionRequestModel {
  final String title;
  final String description;
  final double startingPrice;
  final int bidIncrement;
  final DateTime? startDate;
  final DateTime? endDate;
  final XFile? headImage;
  final List<AuctionItemModel> items;

  const CreateAuctionRequestModel({
    required this.title,
    required this.description,
    required this.startingPrice,
    required this.bidIncrement,
    required this.startDate,
    required this.endDate,
    required this.headImage,
    required this.items,
  });

  CreateAuctionRequestModel copyWith({
    String? title,
    String? description,
    double? startingPrice,
    int? bidIncrement,
    DateTime? startDate,
    DateTime? endDate,
    bool clearStartDate = false,
    bool clearEndDate = false,
    XFile? headImage,
    bool clearHeadImage = false,
    List<AuctionItemModel>? items,
  }) {
    return CreateAuctionRequestModel(
      title: title ?? this.title,
      description: description ?? this.description,
      startingPrice: startingPrice ?? this.startingPrice,
      bidIncrement: bidIncrement ?? this.bidIncrement,
      startDate: clearStartDate ? null : (startDate ?? this.startDate),
      endDate: clearEndDate ? null : (endDate ?? this.endDate),
      headImage: clearHeadImage ? null : (headImage ?? this.headImage),
      items: items ?? this.items,
    );
  }
}

class AuctionItemModel {
  final String title;
  final int count;
  final String description;
  final String warrantyInfo;
  final int condition;
  final int categoryId;
  final List<XFile> images;
  final List<ItemAttributeValueModel> attributes;

  const AuctionItemModel({
    required this.title,
    required this.count,
    required this.description,
    required this.warrantyInfo,
    required this.condition,
    required this.categoryId,
    required this.images,
    required this.attributes,
  });
}

class ItemAttributeValueModel {
  final int categoryAttributeId;
  final String value;

  const ItemAttributeValueModel({
    required this.categoryAttributeId,
    required this.value,
  });

  factory ItemAttributeValueModel.fromJson(Map<String, dynamic> json) {
    return ItemAttributeValueModel(
      categoryAttributeId:
          (json['categoryAttributeId'] ?? json['CategoryAttributeId'] ?? 0)
              as int,
      value: (json['value'] ?? json['Value'] ?? '').toString(),
    );
  }
}
