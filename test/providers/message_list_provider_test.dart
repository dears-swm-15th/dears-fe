import 'package:dears/models/message.dart';
import 'package:dears/providers/message_list_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils.dart';

void main() {
  test("messageListProvider test", () {
    final list = [
      Message(
        isMe: false,
        message: "안녕하세요! 웨딩 준비는 잘 진행되고 있나요? 궁금한 점이 있으면 언제든지 말씀해 주세요.",
        createdAt: DateTime(2023, 7, 7, 9, 30),
      ),
      Message(
        isMe: true,
        message: "예식장 방문 일정도 조율하고 싶습니다. 이번 주말에 가능할까요?",
        createdAt: DateTime(2024, 7, 7, 9, 30),
      ),
      Message(
        isMe: false,
        message: "네 잠시만요~",
        createdAt: DateTime(2024, 7, 7, 9, 30),
      ),
      Message(
        isMe: false,
        message: "확인 후 연락드리겠습니다^^",
        createdAt: DateTime(2024, 7, 7, 9, 31),
      ),
      Message(
        isMe: true,
        message: "감사합니다",
        createdAt: DateTime(2024, 7, 7, 9, 33),
      ),
      Message(
        isMe: false,
        message: "안녕하세요! 웨딩 준비는 잘 진행되고 있나요? 궁금한 점이 있으면 언제든지 말씀해 주세요.",
        createdAt: DateTime(2024, 7, 9, 9, 30),
      ),
      Message(
        isMe: true,
        message: "예식장 방문 일정도 조율하고 싶습니다. 이번 주말에 가능할까요?",
        createdAt: DateTime(2024, 7, 10, 9, 31),
      ),
      Message(
        isMe: false,
        message: "네 잠시만요~",
        createdAt: DateTime(2024, 7, 10, 9, 32),
      ),
      Message(
        isMe: false,
        message: "확인 후 연락드리겠습니다^^",
        createdAt: DateTime(2024, 7, 10, 9, 32),
      ),
      Message(
        isMe: true,
        message: "감사합니다",
        createdAt: DateTime(2024, 7, 10, 12, 1),
      ),
    ];

    final container = createContainer(
      overrides: [
        messageListProvider(0).overrideWith(() => MessageListOverride(list)),
      ],
    );

    expectLater(
      container.read(messageListProvider(0).future),
      completion(isNotEmpty),
    );
  });
}

class MessageListOverride extends MessageList {
  final List<Message> _list;

  MessageListOverride(this._list);

  @override
  Future<List<Message>> build(int id) async {
    return _list;
  }
}
