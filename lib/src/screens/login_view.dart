import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_case/src/db/peopleDB.dart';
import 'package:test_case/src/helpers/alert_dialog.dart';
import 'package:test_case/src/shared/preference.dart';
import 'package:test_case/src/screens/navbar.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GoogleSignIn? _googleSignIn = GoogleSignIn();
  FirebaseAuth? _auth;
  bool isUserSignedIn = false;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void _cekSignIn() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        on_failed(context, "Belum ada user yang login");
      } else {
        setUser([
          user.uid,
          user.email.toString(),
          user.displayName.toString(),
          user.photoURL.toString(),
          user.emailVerified.toString(),
          user.phoneNumber.toString()
        ]);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Navbar()));
      }
    });
  }

  void _onLogin() {
    signInWithGoogle().then((value) => {_cekSignIn()});
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Text(
                'Test Case Login',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () => _onLogin(),
              child: Container(
                width: _size.width * 0.5,
                height: _size.height * 0.07,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Sign In Google",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
