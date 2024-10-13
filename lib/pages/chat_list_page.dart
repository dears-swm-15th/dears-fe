import 'package:dears/providers/chat_list_provider.dart';
import 'package:dears/widgets/chat_list_tile.dart';
import 'package:dears/widgets/custom_app_bar.dart';
import 'package:dears/widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatListPage extends ConsumerWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatList = ref.watch(chatListProvider);

    const emptyWidget = EmptyWidget(
      title: "대화 중인 웨딩플래너가 없습니다",
      subtitle: "마음에 드는 웨딩플래너와 대화해보세요",
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
