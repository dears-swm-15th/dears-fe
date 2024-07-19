import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recent_search_words_provider.g.dart';

const int _capacity = 30;

@riverpod
class RecentSearchWords extends _$RecentSearchWords {
  @override
  List<String> build() {
    return [
      "웨딩플래너",
      "패키지",
      "호텔예식",
      "서울 웨딩플래너",
      "스드메",
    ];
  }

  void add(String value) {
    state.remove(value);
    if (state.length >= _capacity) {
      state.removeLast();
    }

    state = [value.trim().replaceAll(RegExp(r'\s+'), " "), ...state];
  }

  void removeAt(int index) {
    state = [...state..removeAt(index)];
  }

  void clear() {
    state = [];
  }
}
