import 'package:dears/clients/wishlist_client.dart';
import 'package:dears/models/portfolio_overview.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wishlist_provider.g.dart';

@riverpod
Future<List<PortfolioOverview>> wishlist(WishlistRef ref) {
  return wishlistClient.getAll();
}
