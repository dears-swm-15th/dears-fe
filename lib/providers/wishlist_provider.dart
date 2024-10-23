import 'package:dears/models/portfolio_overview.dart';
import 'package:dears/providers/wishlist_client_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wishlist_provider.g.dart';

@riverpod
Future<List<PortfolioOverview>> wishlist(Ref ref) async {
  final wishlistClient = await ref.watch(wishlistClientProvider.future);
  return wishlistClient.getAll();
}
