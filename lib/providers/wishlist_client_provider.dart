import 'package:dears/clients/wishlist_client.dart';
import 'package:dears/providers/api_dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wishlist_client_provider.g.dart';

@riverpod
WishlistClient wishlistClient(WishlistClientRef ref) {
  final dio = ref.watch(apiDioProvider);
  return WishlistClient(dio);
}
