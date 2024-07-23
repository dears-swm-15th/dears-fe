import 'package:dears/widgets/chat_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("채팅"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              physics: const ClampingScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => context.push("/chats/$index"),
                  child: const ChatListTile(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
