import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_case/src/models/getDataModel.dart';
import 'package:test_case/src/models/peopleModel.dart';
import 'package:test_case/src/providers/repositories.dart';

class PeopleDB {
  final _repository = Repositories();
  static PeopleDB? peopleDB;

  static final PeopleDB db = PeopleDB();
  static Database? _database;

  final String db_ini = 'test_case.db';
  final String tb = 'tb_people';

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initDB();
      await getColumnInsert();
      return _database;
    } else {
      return _database;
    }
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + '$db_ini';
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE ${tb} (
        id_people INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        height DOUBLE,
        mass INTEGER,
        hair_color TEXT,
        gender TEXT,
        favourite INTEGER
      )
    ''');
    });
  }

  getColumnInsert() async {
    try {
      GetDataModel resDataModel = await _repository.getData();
      resDataModel.results!.forEach((e) {
        newPeople(People(
          favourite: 0,
          name: e.name,
          height: double.parse(e.height.toString()),
          mass: int.parse(e.mass.toString()),
          hair_color: e.hair_color,
          gender: e.gender == 'female'
              ? 'Female'
              : e.gender == 'male'
                  ? 'Male'
                  : 'Choise your gender',
        ));
      });
    } catch (error) {
      // _dataFetcher.sink.add(error);
      print(error);
    }
  }

  getAllPeoples() async {
    final db = await database;
    var res = await db!.query(tb);
    List<People> list =
        res.isNotEmpty ? res.map((c) => People.fromMap(c)).toList() : [];
    return list;
  }

  getPeople(int id) async {
    final db = await database;
    var res = await db!.query(tb, where: "id_people = ?", whereArgs: [id]);
    return res.isNotEmpty ? People.fromMap(res.first) : Null;
  }

  newPeople(People people) async {
    final db = await database;
    var res = await db!.insert(tb, people.toMap());
    return res;
  }

  updatePeople(People people) async {
    final db = await database;
    var res = await db!.update(tb, people.toMap(),
        where: "id_people = ?", whereArgs: [people.id_people]);
    return res;
  }

  deletePeople(int id) async {
    final db = await database;
    db!.delete(tb, where: "id_people = ?", whereArgs: [id]);
  }

  updateFavourite(int id, int favourite) async {
    final db = await database;
    var res = await db!.update(tb, {'favourite': favourite},
        where: "id_people = ?", whereArgs: [id]);
    return res;
  }

  getFavourite() async {
    final db = await database;
    var res = await db!.query(tb, where: "favourite = ?", whereArgs: [1]);
    List<People> list =
        res.isNotEmpty ? res.map((c) => People.fromMap(c)).toList() : [];
    return list;
  }

  getSearch(String value) async {
    final db = await database;
    var res = await db!.query(tb, where: "name LIKE '%$value%'");
    List<People> list =
        res.isNotEmpty ? res.map((c) => People.fromMap(c)).toList() : [];
    return list;
  }
}
