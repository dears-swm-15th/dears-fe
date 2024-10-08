enum ReviewType {
  consulting("상담"),
  matching("매칭"),
  ;

  final String name;

  const ReviewType(this.name);

  ReviewType get inversed {
    return switch (this) {
      consulting => matching,
      matching => consulting,
    };
  }

  @override
  String toString() => name;
}
