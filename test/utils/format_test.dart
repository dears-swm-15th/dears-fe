import 'package:dears/utils/formats.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("number format test", () {
    expect(number.format(123), "123");
    expect(number.format(1234), "1,234");
    expect(number.format(1234567), "1,234,567");
    expect(number.format(null), "-");
  });

  test("rating format test", () {
    expect(rating.format(0.1), "0.1");
    expect(rating.format(3), "3.0");
    expect(rating.format(null), "-");
  });

  test("search format test", () {
    expect(search.format("hello"), "hello");
    expect(search.format("  hello  "), "hello");
    expect(search.format("   HelLo  wOrlD    "), "hello world");
  });
}
