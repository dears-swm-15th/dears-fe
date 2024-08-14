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
    final updatedList = await wishlistClient.getAll();
    state = AsyncValue.data(updatedList);
  }
  Future<void> removeFromWishList(int portfolioId) async {
    await wishlistClient.delete(portfolioId);
    update((data) => data.where((element) => element.id != portfolioId).toList());
  }
  bool isFavorite(int portfolioId) {
    return state.value?.any((element) => element.id == portfolioId) ?? false;
  }
}
