import 'package:dears/providers/chat_list_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/chat_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatListPage extends ConsumerWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatList = ref.watch(chatListProvider);

    final emptyWidget = Center(
      child: Column(
        children: [
          const Spacer(),
          const Text(
            "대화 중인 웨딩플래너가 없습니다",
            style: titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "마음에 드는 웨딩플래너와 대화해보세요",
            style: bodySmall.copyWith(color: gray600),
          ),
          const Spacer(flex: 2),
        ],
      ),
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
      loading: () {
        return const Center(
          child: Column(
            children: [
              Spacer(),
              CircularProgressIndicator(),
              Spacer(flex: 2),
            ],
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("채팅"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Expanded(child: child),
        ],
      ),
    );
  }
}
