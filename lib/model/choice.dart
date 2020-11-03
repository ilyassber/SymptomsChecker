class Choice {
  Choice({
    this.key,
    this.pkey,
    this.choice,
    this.rate,
    this.checked,
    this.type,
    this.action,
    this.txtValue,
    this.intValue,
    this.doubleValue,
    this.dateValue,
  });

  final int key;
  final int pkey;
  final String choice;
  final double rate;
  bool checked;
  final int type;
   final int action;
  String txtValue;
  int intValue;
  double doubleValue;
  DateTime dateValue;

  static Choice fromMap(Map map){
    return Choice(
      key: map['key'],
      pkey: map['pkey'],
      choice: map['choice'],
      rate: map['rate'],
      checked: map['checked'],
      type: map['type'],
      action: map['action'],
      txtValue: map['txt_value'],
      intValue: map['int_value'],
      doubleValue: map['double_value'],
      dateValue: map['date_value'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'key': key,
      'pkey': pkey,
      'choice': choice,
      'rate': rate,
      'checked': checked,
      'type': type,
      'action': action,
      'txt_value': txtValue,
      'int_value': intValue,
      'double_value': doubleValue,
      'date_value': dateValue,
    };
  }
}
