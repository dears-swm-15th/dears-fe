import 'package:dears/pages/chat_list_page.dart';
import 'package:dears/pages/chat_page.dart';
import 'package:dears/pages/details_page.dart';
import 'package:dears/pages/favorite_page.dart';
import 'package:dears/pages/home_page.dart';
import 'package:dears/pages/personal_page.dart';
import 'package:dears/pages/search_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: "/search",
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: "/favorite",
      builder: (context, state) => const FavoritePage(),
    ),
    GoRoute(
      path: "/chats",
      builder: (context, state) => const ChatListPage(),
    ),
    GoRoute(
      path: "/chats/:chatroomId",
      builder: (context, state) => ChatPage(
        chatroomId: int.parse(state.pathParameters["chatroomId"]!),
      ),
    ),
    GoRoute(
      path: "/personal",
      builder: (context, state) => const PersonalPage(),
    ),
    GoRoute(
      path: "/details/:plannerId",
      builder: (context, state) => DetailsPage(
        plannerId: int.parse(state.pathParameters["plannerId"]!),
      ),
    ),
  ],
);
