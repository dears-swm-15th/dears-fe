import 'dart:async';

import 'package:dears/providers/chat_list_provider.dart';
import 'package:dears/providers/role_provider.dart';
import 'package:dears/widgets/chat_list_tile.dart';
import 'package:dears/widgets/custom_app_bar.dart';
import 'package:dears/widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatListPage extends ConsumerStatefulWidget {
  const ChatListPage({super.key});

  @override
  ConsumerState<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends ConsumerState<ChatListPage> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    // Invalidate the `chatListProvider` when the page is opened.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.invalidate(chatListProvider);
    });

    timer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) => setState(() {}),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mark the `chatList` as loading when the page is opened.
    final chatList = ref.watch(chatListProvider).unwrapPrevious();

    final oppositeRole = ref.watch(roleProvider).requireValue.opposite.label;
    final emptyWidget = EmptyWidget(
      title: "대화 중인 $oppositeRole가 없습니다",
      subtitle: "마음에 드는 $oppositeRole와 대화해보세요",
    );

    final child = chatList.when(
      data: (data) {
        if (data.isEmpty) {
          return emptyWidget;
        }

        return ListView.separated(
          physics: const ClampingScrollPhysics(),
          itemCount: data.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final chat = data[index];
            return ChatListTile(chat);
          },
        );
      },
      error: (error, stackTrace) => emptyWidget,
      loading: () => const LoadingWidget(),
    );

    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("채팅"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
