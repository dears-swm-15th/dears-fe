import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recent_search_words_provider.g.dart';

const int _capacity = 30;

List<String> _words = [
  "웨딩플래너",
  "패키지",
  "호텔예식",
  "서울 웨딩플래너",
  "스드메",
];

@riverpod
class RecentSearchWords extends _$RecentSearchWords {
  @override
  Future<List<String>> build() {
    return Future.delayed(const Duration(milliseconds: 200), () {
      return _words;
    });
  }

  void _save(List<String> data) {
    _words = data;
  }

  void add(String value) {
    update((data) {
      data.remove(value);
      if (data.length >= _capacity) {
        data.removeLast();
      }

      data = [value.trim().replaceAll(RegExp(r'\s+'), " "), ...data];
      _save(data);
      return data;
    });
  }

  void removeAt(int index) {
    update((data) {
      data = [...data..removeAt(index)];
      _save(data);
      return data;
    });
  }

  void clear() {
    update((data) {
      _save([]);
      return [];
    });
  }
}
