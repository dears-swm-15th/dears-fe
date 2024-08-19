import 'package:dears/providers/wish_list_ids_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_wish_listed_provider.g.dart';

@riverpod
Future<bool> isWishListed(IsWishListedRef ref, int portfolioId) async {
  final wishList = await ref.watch(wishListIdsProvider.future);
  return wishList.contains(portfolioId);
}
