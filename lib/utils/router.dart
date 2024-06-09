import 'package:dears/pages/details_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const DetailsPage(),
    ),
  ],
);
