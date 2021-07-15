class GetDataModel {
  int? count;
  String? next;
  String? previous;
  List<Result>? results;

  GetDataModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  GetDataModel.fromJson(Map<String, dynamic> json) {
    count = json["count"]?.toInt();
    next = json["next"]?.toString();
    previous = json["previous"]?.toString();
    if (json["results"] != null) {
      final v = json["results"];
      final arr0 = <Result>[];
      v.forEach((v) {
        arr0.add(Result.fromJson(v));
      });
      results = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["count"] = count;
    data["next"] = next;
    data["previous"] = previous;
    if (results != null) {
      final v = results;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v.toJson());
      });
      data["results"] = arr0;
    }
    return data;
  }
}

class Result {
  String? name;
  String? height;
  String? mass;
  String? hair_color;
  String? skin_color;
  String? eye_color;
  String? birth_year;
  String? gender;
  String? homeworld;
  List<String?>? films;
  List<String?>? species;
  List<String?>? vehicles;
  List<String?>? starships;
  String? created;
  String? edited;
  String? url;

  Result({
    this.name,
    this.height,
    this.mass,
    this.hair_color,
    this.skin_color,
    this.eye_color,
    this.birth_year,
    this.gender,
    this.homeworld,
    this.films,
    this.species,
    this.vehicles,
    this.starships,
    this.created,
    this.edited,
    this.url,
  });
  Result.fromJson(Map<String, dynamic> json) {
    name = json["name"]?.toString();
    height = json["height"]?.toString();
    mass = json["mass"]?.toString();
    hair_color = json["hair_color"]?.toString();
    skin_color = json["skin_color"]?.toString();
    eye_color = json["eye_color"]?.toString();
    birth_year = json["birth_year"]?.toString();
    gender = json["gender"]?.toString();
    homeworld = json["homeworld"]?.toString();
    if (json["films"] != null) {
      final v = json["films"];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      films = arr0;
    }
    if (json["vehicles"] != null) {
      final v = json["vehicles"];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      vehicles = arr0;
    }
    if (json["starships"] != null) {
      final v = json["starships"];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      starships = arr0;
    }
    created = json["created"]?.toString();
    edited = json["edited"]?.toString();
    url = json["url"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    data["height"] = height;
    data["mass"] = mass;
    data["hair_color"] = hair_color;
    data["skin_color"] = skin_color;
    data["eye_color"] = eye_color;
    data["birth_year"] = birth_year;
    data["gender"] = gender;
    data["homeworld"] = homeworld;
    if (films != null) {
      final v = films;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data["films"] = arr0;
    }
    if (vehicles != null) {
      final v = vehicles;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data["vehicles"] = arr0;
    }
    if (starships != null) {
      final v = starships;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data["starships"] = arr0;
    }
    data["created"] = created;
    data["edited"] = edited;
    data["url"] = url;
    return data;
  }
}
