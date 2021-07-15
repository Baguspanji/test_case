import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_case/src/blocs/dataBloc.dart';
import 'package:test_case/src/helpers/alert_dialog.dart';
import 'package:test_case/src/models/peopleModel.dart';

class EditView extends StatefulWidget {
  final int id;
  const EditView({Key? key, required this.id}) : super(key: key);

  @override
  _EditViewState createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  final nameController = TextEditingController();
  final heightController = TextEditingController();
  final massController = TextEditingController();
  final hairController = TextEditingController();

  String gender = 'Choise your gender';
  int favourite = 0;

  void _on_update(context) {
    if (_formKey.currentState!.validate()) {
      People people = People(
        id_people: widget.id,
        name: nameController.text,
        height: double.parse(heightController.text),
        mass: int.parse(massController.text),
        hair_color: hairController.text,
        gender: gender,
        favourite: favourite,
      );
      blocData.editPeople(people);

      on_success(context, "Data Update Successfull!!", Navigator.pop(context));
    }
  }

  @override
  void initState() {
    super.initState();
    blocData.getPeopleById(widget.id);
    blocData.resPeopleId.listen((value) {
      nameController.text = value.name!;
      heightController.text = value.height!.toString();
      massController.text = value.mass!.toString();
      hairController.text = value.hair_color!;
      gender = value.gender!;
      favourite = value.favourite!;
      setState(() {});
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.only(top: 140),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildInput(_size, nameController, "Insert your name"),
              buildInput(_size, heightController, "Insert your height",
                  type: TextInputType.number),
              buildInput(_size, massController, "Insert your mass",
                  type: TextInputType.number),
              buildInput(_size, hairController, "Insert your hair color"),
              buildDropdown(_size),
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
                  onPressed: () => _on_update(context),
                  child: Text(
                    "Update Data",
                    style: TextStyle(fontSize: 24, color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildInput(
      Size _size, TextEditingController controller, String placeholder,
      {TextInputType type = TextInputType.text}) {
    return Container(
      width: _size.width * 0.7,
      height: 60,
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        keyboardType: type,
        controller: controller,
        decoration: new InputDecoration(
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          hintText: placeholder,
        ),
      ),
    );
  }

  Container buildDropdown(Size _size) {
    return Container(
      alignment: Alignment.center,
      width: _size.width * 0.7,
      height: 60,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(width: 2, color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: gender,
        elevation: 16,
        style: const TextStyle(color: Colors.black87),
        onChanged: (String? value) {
          setState(() {
            gender = value!;
          });
        },
        items: <String>[
          'Choise your gender',
          'Male',
          'Female',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              width: _size.width * 0.6,
              child: Text(
                value,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
