class ViewAuctionRouteArgs {
  final int auctionId;

  /// Optional display title shown in the AppBar while data is loading.
  final String? auctionTitle;

  const ViewAuctionRouteArgs({
    required this.auctionId,
    this.auctionTitle,
  });
}
