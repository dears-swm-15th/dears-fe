import 'package:dears/models/member_role.dart';
import 'package:dears/pages/chat_list_page.dart';
import 'package:dears/pages/chat_page.dart';
import 'package:dears/pages/chat_redirect_page.dart';
import 'package:dears/pages/details_page.dart';
import 'package:dears/pages/favorite_page.dart';
import 'package:dears/pages/home_page.dart';
import 'package:dears/pages/inquiry_page.dart';
import 'package:dears/pages/loading_page.dart';
import 'package:dears/pages/personal_page.dart';
import 'package:dears/pages/role_selection_page.dart';
import 'package:dears/pages/search_page.dart';
import 'package:dears/pages/search_result_page.dart';
import 'package:dears/providers/planner_page.dart';
import 'package:dears/providers/user_info_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final userInfo = ref.watch(userInfoProvider);
  return GoRouter(
    redirect: (context, state) {
      return userInfo.maybeWhen(
        data: (user) {
          if (user.uuid == null) {
            if (state.matchedLocation != "/select-role") {
              return "/select-role";
            }
          } else {
            if(state.matchedLocation == "/") {
              if (user.role == MemberRole.customer) {
                return "/";
              } else if (user.role == MemberRole.weddingPlanner) {
                return "/planner";
              }
            }
            return null;
          }
          // No redirection required if the user is on the correct page.
          return null;
        },
        orElse: () {
          // If the userInfo is still loading, redirect to the loading page.
          if (state.matchedLocation != "/loading") {
            return "/loading";
          }
          return null;
        },
      );
    },
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: "/search",
        builder: (context, state) {
          final query = state.uri.queryParameters["q"];
          if (query != null) {
            return SearchResultPage(query: query);
          }
          return const SearchPage();
        },
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
        path: "/chats/redirect/:portfolioId",
        builder: (context, state) => ChatRedirectPage(
          portfolioId: int.parse(state.pathParameters["portfolioId"]!),
        ),
      ),
      GoRoute(
        path: "/personal",
        builder: (context, state) => const PersonalPage(),
      ),
      GoRoute(
        path: "/inquiry",
        builder: (context, state) => const InquiryPage(),
      ),
      GoRoute(
        path: "/details/:portfolioId",
        builder: (context, state) => DetailsPage(
          portfolioId: int.parse(state.pathParameters["portfolioId"]!),
        ),
      ),
      GoRoute(
        path: "/select-role",
        builder: (context, state) => const RoleSelectionPage(),
      ),
      GoRoute(
        path: "/loading",
        builder: (context, state) {
          return const LoadingPage();
        },
      ),
      GoRoute(
          path: "/planner", builder: (context, state) => const PlannerPage()),
    ],
  );
}
