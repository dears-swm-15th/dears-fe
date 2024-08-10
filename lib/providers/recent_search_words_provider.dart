import 'package:dears/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recent_search_words_provider.g.dart';

const String _key = "recent_search_words";

const int _capacity = 30;

@riverpod
class RecentSearchWords extends _$RecentSearchWords {
  @override
  Future<List<String>> build() async {
    final prefs = ref.watch(prefsProvider);

    final value = await prefs.getStringList(_key) ?? [];
    ref.onDispose(_save);

    return [...value];
  }

  /// Save the search history to the shared preferences asynchronously.
  void _save() {
    final prefs = ref.read(prefsProvider);
    state.whenOrNull(data: (data) => prefs.setStringList(_key, data).ignore());
  }

  void add(String value) {
    update(
      (data) {
        data.remove(value);
        if (data.length >= _capacity) {
          data.removeLast();
        }

        return [value, ...data];
      },
      onError: (err, stackTrace) => [value],
    );
  }

  void removeAt(int index) {
    update(
      (data) => [...data..removeAt(index)],
      onError: (err, stackTrace) => [],
    );
  }

  void clear() {
    update(
      (data) => [],
      onError: (err, stackTrace) => [],
    );
  }
}
