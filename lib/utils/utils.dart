extension AndThen<T> on T? {
  S? andThen<S>(S? Function(T t) f) {
    final self = this;
    return self != null ? f(self) : null;
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
