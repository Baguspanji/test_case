import 'package:flutter/material.dart';
import 'package:test_case/src/blocs/dataBloc.dart';
import 'package:test_case/src/helpers/alert_dialog.dart';
import 'package:test_case/src/models/getUserModel.dart';
import 'package:test_case/src/models/peopleModel.dart';
import 'package:test_case/src/screens/detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool view = true;

  @override
  void initState() {
    super.initState();
    blocData.getAllPeople();
  }

  void _onChange(value) {
    if (value == '') {
      blocData.getAllPeople();
    } else {
      blocData.getSearch(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 40),
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildInput(_size, "Search Name.."),
              Container(
                width: _size.width * 0.15,
                height: _size.width * 0.15,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      view = !view;
                    });
                  },
                  child: Icon(
                    view ? Icons.view_list_outlined : Icons.view_quilt_outlined,
                    size: 34,
                    color: Colors.grey.shade600,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 90),
          padding: EdgeInsets.all(20),
          child: StreamBuilder(
            stream: blocData.resPeople.stream,
            builder: (context, AsyncSnapshot<List<People>> snapshot) {
              if (snapshot.hasData) {
                if (view) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      final item = snapshot.data![i];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailView(id: item.id_people!),
                            ),
                          );
                        },
                        child: Container(
                          width: _size.width * 0.9,
                          height: _size.height * 0.1,
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 2, color: Colors.green.shade200),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.name}',
                                style: TextStyle(fontSize: 20),
                              ),
                              InkWell(
                                onTap: () {
                                  blocData.editFavourite(item.id_people!,
                                      item.favourite == 1 ? 0 : 1);
                                },
                                child: item.favourite! == 1
                                    ? Icon(
                                        Icons.favorite,
                                        size: 34,
                                        color: Colors.red.shade700,
                                      )
                                    : Icon(
                                        Icons.favorite_outline,
                                        size: 34,
                                        color: Colors.grey.shade700,
                                      ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, i) {
                      final item = snapshot.data![i];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailView(id: item.id_people!),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 2, color: Colors.green.shade200),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.name}',
                                style: TextStyle(fontSize: 20),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () {
                                    blocData.editFavourite(item.id_people!,
                                        item.favourite == 1 ? 0 : 1);
                                  },
                                  child: item.favourite! == 1
                                      ? Icon(
                                          Icons.favorite,
                                          size: 34,
                                          color: Colors.red.shade700,
                                        )
                                      : Icon(
                                          Icons.favorite_outline,
                                          size: 34,
                                          color: Colors.grey.shade700,
                                        ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Container buildInput(Size _size, String placeholder,
      {TextInputType type = TextInputType.text}) {
    return Container(
      width: _size.width * 0.7,
      height: 60,
      child: TextFormField(
        onChanged: (value) => _onChange(value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        textInputAction: TextInputAction.search,
        keyboardType: type,
        decoration: new InputDecoration(
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          hintText: placeholder,
        ),
      ),
    );
  }
}
