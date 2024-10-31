enum ReviewType {
  consulting("상담"),
  matching("매칭"),
  ;

  final String label;

  const ReviewType(this.label);

  ReviewType get inversed {
    return switch (this) {
      consulting => matching,
      matching => consulting,
    };
  }
}
