class Summary {
  Summary({
    this.key,
    this.pkey,
    this.text,
    this.checked,
    this.eliminated,
    this.eliminate,
  });

  final int key;
  final int pkey;
  String text;
  bool checked;
  bool eliminated;
  List<int> eliminate;

  Summary fromMap(Map<String, dynamic> map) {
    return Summary(
      key: map['key'],
      pkey: map['pkey'],
      text: map['text'],
      checked: map['checked'],
      eliminated: map['eliminated'],
      eliminate: map['eliminate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'pkey': pkey,
      'text': text,
      'checked': checked,
      'eliminated': eliminated,
      'eliminate': eliminate,
    };
  }
}
