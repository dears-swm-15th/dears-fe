import 'package:dears/pages/loading_page.dart';
import 'package:dears/providers/chat_list_provider.dart';
import 'package:dears/providers/chatroom_client_provider.dart';
import 'package:dears/providers/stomp_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatRedirectPage extends ConsumerStatefulWidget {
  final int portfolioId;

  const ChatRedirectPage({
    super.key,
    required this.portfolioId,
  });

  @override
  ConsumerState<ChatRedirectPage> createState() => _ChatRedirectPageState();
}

class _ChatRedirectPageState extends ConsumerState<ChatRedirectPage> {
  @override
  void initState() {
    super.initState();
    redirect().ignore();
  }

  Future<void> redirect() async {
    final chatroomId = await getChatroomIdOf(widget.portfolioId);

    if (!mounted) return;
    context.replace("/chats/$chatroomId");
  }

  Future<int> getChatroomIdOf(int portfolioId) async {
    final chatList = await ref.read(chatListProvider.future);

    final i = chatList.indexWhere((e) => e.portfolioId == portfolioId);
    if (i != -1) {
      return chatList[i].id;
    }

    final chatroomClient = await ref.read(chatroomClientProvider.future);
    final chatroom = await chatroomClient.createOrEnter(portfolioId);
    await ref.read(stompProvider.notifier).subscribe(chatroom.id);

    return chatroom.id;
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingPage();
  }
}
