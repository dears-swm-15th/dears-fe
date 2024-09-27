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
import 'package:dears/pages/planner_page.dart';
import 'package:dears/pages/role_selection_page.dart';
import 'package:dears/pages/search_page.dart';
import 'package:dears/pages/search_result_page.dart';
import 'package:dears/pages/sign_in_page.dart';
import 'package:dears/providers/is_signed_in_provider.dart';
import 'package:dears/providers/role_provider.dart';
import 'package:dears/providers/uuid_provider.dart';
import 'package:dears/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final isSignedIn = ValueNotifier(false);
  ref.onDispose(isSignedIn.dispose);

  ref.listen(
    isSignedInProvider.selectAsync((data) => data),
    (previous, next) async {
      isSignedIn.value = await next;
    },
  );

  return GoRouter(
    refreshListenable: isSignedIn,
    redirect: (context, state) async {
      logger.t("at global redirect, matched: ${state.matchedLocation}");

      final uuid = await ref.read(uuidProvider.future);
      if (uuid == null) {
        final isRoleFixed = await ref.read(roleProvider.notifier).isFixed;
        if (!isRoleFixed) {
          return "/select-role";
        }
        return "/sign-in";
      }
      return null;
    },
    routes: [
      GoRoute(
        path: "/",
        redirect: (context, state) async {
          logger.t("at '/' redirect, matched: ${state.matchedLocation}");

          final role = await ref.read(roleProvider.future);
          if (role == MemberRole.weddingPlanner) {
            return "/planner";
          }
          return null;
        },
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: "/sign-in",
        builder: (context, state) => const SignInPage(),
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
        builder: (context, state) => const LoadingPage(),
      ),
      GoRoute(
        path: "/planner",
        builder: (context, state) => const PlannerPage(),
      ),
    ],
  );
}
