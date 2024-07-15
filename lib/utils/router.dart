import 'package:dears/pages/details_page.dart';
import 'package:dears/pages/main_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: "/details/:plannerId",
      builder: (context, state) => DetailsPage(
        plannerId: int.parse(state.pathParameters["plannerId"]!),
      ),
    ),
  ],
);
