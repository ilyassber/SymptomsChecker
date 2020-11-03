import 'package:anticorona/model/choice.dart';

class User {
  User({
    this.key,
    this.pseudo,
    this.name,
    this.birthday,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.choices,
  });

  final int key;
  final String pseudo;
  String name;
  DateTime birthday;
  int age;
  String gender;
  int height;
  int weight;
  List<Choice> choices = [];

  User fromMap(Map<String, dynamic> map) {
    return User(
      key: map['key'],
      pseudo: map['pseudo'],
      name: map['name'],
      birthday: DateTime.parse(map['birthday']),
      age: map['age'],
      gender: map['gender'],
      height: map['height'],
      weight: map['weight'],
      choices: (map['choices'] != null && map['choices'] != '[]')
          ? List<Choice>.from(map['choices'].map((x) => Choice.fromMap(x)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'pseudo': pseudo,
      'name': name,
      'birthday': birthday.toIso8601String(),
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'choices':
          (choices != null) ? choices.map((x) => x.toMap()).toList() : null,
    };
  }

  void routeAction(Choice choice) {
    if (choice.action == 1) {
      updateName(choice);
    } else if (choice.action == 2) {
      updateHeight(choice);
    } else if (choice.action == 3) {
      updateWeight(choice);
    } else if (choice.action == 4) {
      updateBirthday(choice);
    } else if (choice.action == 5) {
      updateGender(choice);
    }
  }

  void updateName(Choice choice) {
    this.name = choice.txtValue;
  }

  void updateBirthday(Choice choice) {
    if (choice.dateValue != null) {
      DateTime now = DateTime.now();
      this.birthday = choice.dateValue;
      this.age = now.year - choice.dateValue.year;
      if (now.month < choice.dateValue.month ||
          (now.month == choice.dateValue.month &&
              now.day < choice.dateValue.day)) {
        this.age--;
      }
      choice.intValue = age;
    }
  }

  void updateGender(Choice choice) {
    this.gender = choice.txtValue;
  }

  void updateHeight(Choice choice) {
    this.height = choice.intValue;
  }

  void updateWeight(Choice choice) {
    this.weight = choice.intValue;
  }
}
