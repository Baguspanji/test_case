import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_case/src/shared/preference.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({Key? key}) : super(key: key);

  @override
  _ProfilViewState createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  String email = '';
  String nama = '';
  String urlPhoto =
      'https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg';

  @override
  void initState() {
    super.initState();
    getUser().then((user) {
      email = user[1];
      nama = user[2];
      urlPhoto = user[3];
      setState(() {});
    });
  }

  Future<void> _onSignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 200),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: _size.width * 0.6,
            height: _size.width * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(120),
              image: DecorationImage(
                image: NetworkImage(urlPhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
          newMethod(email),
          newMethod(nama),
          Container(
            width: _size.width * 0.6,
            height: _size.height * 0.06,
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
              onPressed: () => _onSignOut().then(
                  (value) => Navigator.pushReplacementNamed(context, '/login')),
              child: Text(
                "Sign Out",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container newMethod(String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Text(
        value,
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}
