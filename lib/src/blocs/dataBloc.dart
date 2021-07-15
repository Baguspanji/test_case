import 'package:test_case/src/db/peopleRepo.dart';
import 'package:test_case/src/models/getDataModel.dart';
import 'package:test_case/src/models/getUserModel.dart';
import 'package:test_case/src/models/peopleModel.dart';
import 'package:test_case/src/providers/repositories.dart';
import 'package:rxdart/rxdart.dart';

class DataBloc {
  final _repository = Repositories();
  final _people = PeopleRepo();

  final _dataFetcher = PublishSubject<GetDataModel>();
  final _peopleFetcher = PublishSubject<List<People>>();
  final _peopleIdFetcher = PublishSubject<People>();
  final _favouriteFetcher = PublishSubject<List<People>>();
  final _viewFetcher = PublishSubject<bool>();

  PublishSubject<GetDataModel> get resData => _dataFetcher;
  PublishSubject<List<People>> get resPeople => _peopleFetcher;
  PublishSubject<People> get resPeopleId => _peopleIdFetcher;
  PublishSubject<List<People>> get resFavourite => _favouriteFetcher;
  PublishSubject<bool> get resview => _viewFetcher;

  getView() async {
    try {
      bool resView = await true;
      _viewFetcher.sink.add(resView);
    } catch (e) {
      print(e);
    }
  }

  changeView(bool view) async {
    try {
      bool resView = await !view;
      _viewFetcher.sink.add(resView);
    } catch (e) {
      print(e);
    }
  }

  getData() async {
    try {
      GetDataModel resDataModel = await _repository.getData();
      _dataFetcher.sink.add(resDataModel);
    } catch (error) {
      // _dataFetcher.sink.add(error);
      print(error);
    }
  }

  getSearch(String value) async {
    try {
      List<People> resPeople = await _people.getSearch(value);
      _peopleFetcher.sink.add(resPeople);
    } catch (e) {
      // _peopleFetcher.sink.add(e);
      print(e);
    }
  }

  getAllPeople() async {
    try {
      List<People> resPeople = await _people.getAllPeople();
      _peopleFetcher.sink.add(resPeople);
    } catch (e) {
      // _peopleFetcher.sink.add(e);
      print(e);
    }
  }

  getPeopleById(int id) async {
    try {
      People resPeople = await _people.getPeopleById(id);
      _peopleIdFetcher.sink.add(resPeople);
    } catch (e) {
      // _peopleFetcher.sink.add(e);
      print(e);
    }
  }

  addPeople(People people) async {
    try {
      await _people.addPeople(people);
      getAllPeople();
    } catch (e) {
      print(e);
    }
  }

  editPeople(People people) async {
    try {
      await _people.editPeople(people);
      getAllPeople();
      getPeopleById((people.id_people!));
    } catch (e) {
      print(e);
    }
  }

  deletePeople(int id) async {
    try {
      await _people.deletePeople(id);
      getAllPeople();
    } catch (e) {
      print(e);
    }
  }

  getFavourite() async {
    try {
      List<People> resFavourite = await _people.getFavourite();
      _favouriteFetcher.sink.add(resFavourite);
    } catch (e) {
      // _peopleFetcher.sink.add(e);
      print(e);
    }
  }

  editFavourite(int id, int favourite) async {
    try {
      await _people.updateFavourite(id, favourite);
      getFavourite();
      getAllPeople();
    } catch (e) {
      print(e);
    }
  }

  dispose() {
    _dataFetcher.close();
    _peopleFetcher.close();
    _peopleIdFetcher.close();
    _favouriteFetcher.close();
    _viewFetcher.close();
  }
}

final blocData = DataBloc();
