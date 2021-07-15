import 'package:flutter/material.dart';
import 'package:test_case/src/blocs/dataBloc.dart';
import 'package:test_case/src/models/getDataModel.dart';
import 'package:test_case/src/models/peopleModel.dart';
import 'package:test_case/src/screens/detail_view.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  _FavouriteViewState createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  @override
  void initState() {
    super.initState();
    blocData.getFavourite();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      child: StreamBuilder(
        stream: blocData.resFavourite.stream,
        builder: (context, AsyncSnapshot<List<People>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                final item = snapshot.data![i];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailView(id: item.id_people!),
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
                      border:
                          Border.all(width: 2, color: Colors.green.shade200),
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
                            blocData.editFavourite(
                                item.id_people!, item.favourite == 1 ? 0 : 1);
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
    );
  }
}
