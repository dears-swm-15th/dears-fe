extension AndThen<T> on T? {
  S? andThen<S>(S? Function(T) f) {
    final t = this;
    return t != null ? f(t) : null;
  }
}

extension Separated<T> on Iterable<T> {
  Iterable<T> separated(T separator) sync* {
    final iterator = this.iterator;
    if (!iterator.moveNext()) {
      return;
    }

    yield iterator.current;
    while (iterator.moveNext()) {
      yield separator;
      yield iterator.current;
    }
  }
}

bool isSameMinute(DateTime? dateA, DateTime? dateB) {
  return dateA?.year == dateB?.year &&
      dateA?.month == dateB?.month &&
      dateA?.day == dateB?.day &&
      dateA?.hour == dateB?.hour &&
      dateA?.minute == dateB?.minute;
}
