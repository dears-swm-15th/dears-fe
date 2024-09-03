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
    redirect();
  }

  Future<void> redirect() async {
    final chatList = await ref.read(chatListProvider.future);

    final i = chatList.indexWhere((e) => e.portfolioId == widget.portfolioId);
    if (i != -1) {
      final chatroomId = chatList[i].id;

      if (mounted) {
        context.replace("/chats/$chatroomId");
      }
      return;
    }

    final chatroomClient = await ref.read(chatroomClientProvider.future);
    final chatroom = await chatroomClient.createOrEnter(widget.portfolioId);
    await ref.read(stompProvider.notifier).subscribe(chatroom.id);

    if (mounted) {
      context.replace("/chats/${chatroom.id}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingPage();
  }
}
