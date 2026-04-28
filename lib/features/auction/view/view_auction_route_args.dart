class ViewAuctionRouteArgs {
  final int auctionId;

  /// Optional display title shown in the AppBar while data is loading.
  final String? auctionTitle;

  /// The item index to display initially (defaults to 0).
  final int initialItemIndex;

  const ViewAuctionRouteArgs({
    required this.auctionId,
    this.auctionTitle,
    this.initialItemIndex = 0,
  });
}
