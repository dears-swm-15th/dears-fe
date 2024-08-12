import 'package:dears/utils/formats.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("search format test", () {
    expect(search.format("hello"), "hello");
    expect(search.format("  hello  "), "hello");
    expect(search.format("   HelLo  wOrlD    "), "hello world");
  });
}
