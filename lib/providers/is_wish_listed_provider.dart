import 'package:dears/providers/wish_list_ids_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_wish_listed_provider.g.dart';

@riverpod
Future<bool> isWishListed(Ref ref, int portfolioId) {
  return ref.watch(
    wishListIdsProvider.selectAsync((data) => data.contains(portfolioId)),
  );
}
