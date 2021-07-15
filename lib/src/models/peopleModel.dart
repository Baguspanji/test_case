import 'dart:convert';

People peopleFromJson(String str) {
  final jsonData = json.decode(str);
  return People.fromMap(jsonData);
}

String PeopleToJson(People data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class People {
  final int? id_people;
  final String? name;
  final double? height;
  final int? mass;
  final String? hair_color;
  final String? gender;
  final int? favourite;

  People({
    this.id_people,
    required this.favourite,
    required this.name,
    required this.height,
    required this.mass,
    required this.hair_color,
    required this.gender,
  });

  factory People.fromMap(Map<String, dynamic> json) => new People(
        id_people: json["id_people"],
        name: json["name"],
        height: json["height"],
        mass: json["mass"],
        hair_color: json["hair_color"],
        gender: json["gender"],
        favourite: json["favourite"],
      );

  Map<String, dynamic> toMap() => {
        "id_people": id_people,
        "name": name,
        "height": height,
        "mass": mass,
        "hair_color": hair_color,
        "gender": gender,
        "favourite": favourite,
      };
}
