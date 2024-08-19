import 'package:dears/models/review.dart';
import 'package:dears/providers/portfolio_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_list_provider.g.dart';

@riverpod
Future<List<Review>> reviewList(ReviewListRef ref, int portfolioId) async {
  final portfolioClient = await ref.watch(portfolioClientProvider.future);
  return portfolioClient.getAllReviews(portfolioId);
}
