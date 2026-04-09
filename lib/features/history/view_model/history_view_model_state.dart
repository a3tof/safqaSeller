import 'package:equatable/equatable.dart';
import 'package:safqaseller/features/history/model/models/history_models.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySuccess extends HistoryState {
  final List<HistoryItem> items;
  final int currentPage;
  final int pageSize;
  final bool hasMore;
  final int totalCount;
  final AuctionStatus? status;

  const HistorySuccess({
    required this.items,
    required this.currentPage,
    required this.pageSize,
    required this.hasMore,
    required this.totalCount,
    this.status,
  });

  int get totalPages => totalCount == 0 ? 1 : (totalCount / pageSize).ceil();

  HistorySuccess copyWith({
    List<HistoryItem>? items,
    int? currentPage,
    int? pageSize,
    bool? hasMore,
    int? totalCount,
    Object? status = _sentinel,
  }) {
    return HistorySuccess(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      hasMore: hasMore ?? this.hasMore,
      totalCount: totalCount ?? this.totalCount,
      status: identical(status, _sentinel)
          ? this.status
          : status as AuctionStatus?,
    );
  }

  @override
  List<Object?> get props => [
    items,
    currentPage,
    pageSize,
    hasMore,
    totalCount,
    status,
  ];
}

class HistoryFailure extends HistoryState {
  final String message;

  const HistoryFailure(this.message);

  @override
  List<Object?> get props => [message];
}

const Object _sentinel = Object();
