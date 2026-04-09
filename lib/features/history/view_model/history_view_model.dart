import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/features/history/model/models/history_models.dart';
import 'package:safqaseller/features/history/model/repositories/history_repository.dart';
import 'package:safqaseller/features/history/view_model/history_view_model_state.dart';

class HistoryViewModel extends Cubit<HistoryState> {
  final HistoryRepository _repository;

  static const int _pageSize = 10;

  HistoryViewModel(this._repository) : super(HistoryInitial());

  Future<void> loadPage(int page, {AuctionStatus? status}) async {
    emit(HistoryLoading());
    try {
      final response = await _repository.getHistory(
        page: page,
        pageSize: _pageSize,
        status: status,
      );
      emit(
        HistorySuccess(
          items: response.items,
          currentPage: response.page,
          pageSize: response.pageSize,
          hasMore: response.hasMore,
          totalCount: response.totalCount,
          status: status,
        ),
      );
    } catch (e) {
      emit(HistoryFailure(_clean(e)));
    }
  }

  Future<void> goToPage(int page) async {
    final currentState = state;
    if (currentState is! HistorySuccess) {
      await loadPage(page);
      return;
    }

    final totalPages = currentState.totalPages;
    if (page < 1 || page > totalPages || page == currentState.currentPage) {
      return;
    }

    await loadPage(page, status: currentState.status);
  }

  Future<void> refresh() => loadPage(1, status: _selectedStatus);

  AuctionStatus? get _selectedStatus {
    final currentState = state;
    return currentState is HistorySuccess ? currentState.status : null;
  }

  String _clean(Object error) {
    var message = error.toString();
    if (message.startsWith('Exception: ')) {
      message = message.replaceFirst('Exception: ', '');
    }
    return message;
  }
}
