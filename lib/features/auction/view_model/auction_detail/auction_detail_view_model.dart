import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/features/auction/model/models/auction_detail_model.dart';
import 'package:safqaseller/features/auction/model/repositories/auction_repository.dart';
import 'package:safqaseller/features/auction/view_model/auction_detail/auction_detail_view_model_state.dart';

class AuctionDetailViewModel extends Cubit<AuctionDetailViewModelState> {
  final AuctionRepository auctionRepository;

  AuctionDetailViewModel(this.auctionRepository)
    : super(AuctionDetailInitial());

  AuctionDetailModel? detail;

  Future<void> loadAuction(int id) async {
    emit(AuctionDetailLoading());
    try {
      final loadedDetail = await auctionRepository.viewAuction(id);
      detail = loadedDetail;
      emit(AuctionDetailLoaded(loadedDetail));
    } catch (e) {
      emit(AuctionDetailFailure(_clean(e)));
    }
  }

  Future<void> deleteAuction(int id) async {
    final currentDetail = detail;
    if (currentDetail != null) {
      emit(AuctionDetailDeleting(currentDetail));
    } else {
      emit(AuctionDetailLoading());
    }

    try {
      await auctionRepository.deleteAuction(id);
      emit(AuctionDetailDeleteSuccess());
    } catch (e) {
      if (currentDetail != null) {
        emit(AuctionDetailLoaded(currentDetail));
      }
      emit(AuctionDetailFailure(_clean(e)));
    }
  }

  String _clean(Object error) {
    final message = error.toString();
    if (message.startsWith('Exception: ')) {
      return message.replaceFirst('Exception: ', '');
    }
    return message;
  }
}
