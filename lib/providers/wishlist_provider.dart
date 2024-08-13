import 'package:dears/clients/wishlist_client.dart';
import 'package:dears/models/portfolio_overview.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wishlist_provider.g.dart';

@riverpod
class Wishlist extends _$Wishlist {

  @override
  Future<List<PortfolioOverview>> build() async {
    return wishlistClient.getAll();
  }
  Future<void> addToWishList(int portfolioId) async {
    await wishlistClient.add(portfolioId);
  }
  Future<void> removeFromWishList(int portfolioId) async {
    await wishlistClient.delete(portfolioId);
  }
}
