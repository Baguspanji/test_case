import 'package:test_case/src/db/peopleDB.dart';
import 'package:test_case/src/models/peopleModel.dart';

class PeopleRepo {
  final dbPeople = PeopleDB();

  Future getAllPeople() => dbPeople.getAllPeoples();

  Future getPeopleById(int id) => dbPeople.getPeople(id);

  Future addPeople(People people) => dbPeople.newPeople(people);

  Future editPeople(People people) => dbPeople.updatePeople(people);

  Future deletePeople(int id) => dbPeople.deletePeople(id);

  Future getFavourite() => dbPeople.getFavourite();

  Future updateFavourite(int id, int favourite) =>
      dbPeople.updateFavourite(id, favourite);

  Future getSearch(String value) => dbPeople.getSearch(value);
}
