import 'package:safqaseller/features/auction/model/models/auction_detail_model.dart';

abstract class EditAuctionViewModelState {}

class EditAuctionInitial extends EditAuctionViewModelState {}

class EditAuctionLoading extends EditAuctionViewModelState {}

class EditAuctionLoaded extends EditAuctionViewModelState {
  final AuctionDetailModel detail;

  EditAuctionLoaded(this.detail);
}

class EditAuctionSaving extends EditAuctionLoaded {
  EditAuctionSaving(super.detail);
}

class EditAuctionSaveSuccess extends EditAuctionViewModelState {}

class EditAuctionFailure extends EditAuctionViewModelState {
  final String message;

  EditAuctionFailure(this.message);
}
