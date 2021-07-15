import 'package:flutter/material.dart';
import 'package:test_case/src/blocs/dataBloc.dart';
import 'package:test_case/src/helpers/alert_dialog.dart';
import 'package:test_case/src/models/peopleModel.dart';
import 'package:test_case/src/screens/edit_view.dart';

class DetailView extends StatefulWidget {
  final int id;
  const DetailView({Key? key, required this.id}) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  void initState() {
    super.initState();
    blocData.getPeopleById(widget.id);
  }

  void _on_delete(context) {
    blocData.deletePeople(widget.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: blocData.resPeopleId.stream,
              builder: (context, AsyncSnapshot<People> snapshot) {
                final item = snapshot.data!;
                if (snapshot.hasData) {
                  return Container(
                    width: _size.width * 0.8,
                    height: _size.height * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(item.name!, style: TextStyle(fontSize: 26)),
                        Text(item.height!.toString(),
                            style: TextStyle(fontSize: 26)),
                        Text(item.mass!.toString(),
                            style: TextStyle(fontSize: 26)),
                        Text(item.hair_color!, style: TextStyle(fontSize: 26)),
                        Text(item.gender!, style: TextStyle(fontSize: 26)),
                      ],
                    ),
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
            Container(
              width: _size.width * 0.6,
              height: _size.height * 0.06,
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.greenAccent,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditView(id: widget.id),
                    ),
                  );
                },
                child: Text(
                  "Edit Data",
                  style: TextStyle(fontSize: 24, color: Colors.black54),
                ),
              ),
            ),
            Container(
              width: _size.width * 0.6,
              height: _size.height * 0.06,
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.redAccent,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  on_warning(
                      context, "Are sure deleting data?", _on_delete(context));
                },
                child: Text(
                  "Hapus Data",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
