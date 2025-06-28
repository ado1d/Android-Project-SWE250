class Crypto {
  final String id;
  final String name;
  final String symbol;
  final double price;
  final double changePercent;
  final String imageUrl;
  // final double? marketCap;
  final double? volume;
  final int? marketCapRank;

  Crypto({
    required this.id,
    required this.name,
    required this.symbol,
    required this.price,
    required this.changePercent,
    required this.imageUrl,
    // this.marketCap,
    this.volume,
    this.marketCapRank,
  });
}
