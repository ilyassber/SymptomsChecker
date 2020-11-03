class Relation {
  Relation({
    this.relatedToC,
    this.relatedToR,
    this.condition,
    this.less,
    this.more,
  });

  int relatedToC;
  int relatedToR;
  bool condition;
  int less;
  int more;

  static Relation fromMap(Map<String, dynamic> map) {
    return Relation(
      relatedToC: map['related_to_c'],
      relatedToR: map['related_to_r'],
      condition: map['condition'],
      less: map['less'],
      more: map['more'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'related_to_c': relatedToC,
      'related_to_r': relatedToR,
      'condition': condition,
      'less': less,
      'more': more,
    };
  }
}
