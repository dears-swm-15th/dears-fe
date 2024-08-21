import 'package:dears/providers/wishlist_client_provider.dart';
import 'package:dears/providers/wishlist_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wish_list_ids_provider.g.dart';

@riverpod
class WishListIds extends _$WishListIds {
  @override
  Future<Set<int>> build() async {
    final wishlist = await ref.watch(wishlistProvider.future);
    return wishlist.map((e) => e.id).toSet();
  }

  Future<void> toggle(int portfolioId) async {
    final data = await future;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final wishlistClient = await ref.read(wishlistClientProvider.future);

      final isWishListed = data.contains(portfolioId);
      if (!isWishListed) {
        await wishlistClient.add(portfolioId);
        data.add(portfolioId);
      } else {
        await wishlistClient.delete(portfolioId);
        data.remove(portfolioId);
      }
      return {...data};
    });
  }
}
