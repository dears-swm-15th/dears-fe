enum ReviewType {
  consulting,
  matching;

  ReviewType get inversed {
    return switch (this) {
      ReviewType.consulting => ReviewType.matching,
      ReviewType.matching => ReviewType.consulting
    };
  }

  @override
  String toString() {
    return switch (this) {
      ReviewType.consulting => "상담",
      ReviewType.matching => "매칭"
    };
  }
}
