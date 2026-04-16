import 'package:safqaseller/features/auction/model/models/auction_detail_model.dart';

abstract class AuctionDetailViewModelState {}

class AuctionDetailInitial extends AuctionDetailViewModelState {}

class AuctionDetailLoading extends AuctionDetailViewModelState {}

class AuctionDetailLoaded extends AuctionDetailViewModelState {
  final AuctionDetailModel detail;

  AuctionDetailLoaded(this.detail);
}

class AuctionDetailDeleting extends AuctionDetailLoaded {
  AuctionDetailDeleting(super.detail);
}

class AuctionDetailDeleteSuccess extends AuctionDetailViewModelState {}

class AuctionDetailFailure extends AuctionDetailViewModelState {
  final String message;

  AuctionDetailFailure(this.message);
}
