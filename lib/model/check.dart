import 'package:anticorona/model/choice.dart';
import 'package:anticorona/model/relation.dart';

class Check {
  Check({
    this.key,
    this.situation,
    this.situationL,
    this.checked,
    this.action,
    this.choices,
    this.relations,
  });

  final int key;
  final String situation;
  String situationL;
  bool checked;
  int action;
  final List<Choice> choices;
  final List<Relation> relations;

  static Check fromMap(Map<String, dynamic> map) {
    return Check(
      key: map['key'],
      situation: map['situation'],
      situationL: map['situation_l'],
      checked: map['checked'],
      action: map['action'],
      choices: (map['choices'] != '[]' && map['choices'] != null)
          ? List<Choice>.from(map['choices'].map((x) => Choice.fromMap(x)))
          : [],
      relations: (map['relations'] != '[]' && map['relations'] != null)
          ? List<Relation>.from(map['relations'].map((x) => Relation.fromMap(x)))
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'situation': situation,
      'situation_l': situationL,
      'checked': checked,
      'action': action,
      'choices':
          (choices != null) ? choices.map((x) => x.toMap()).toList() : null,
      'relations':
          (relations != null) ? relations.map((x) => x.toMap()).toList() : null,
    };
  }
}
