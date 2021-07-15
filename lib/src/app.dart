import 'package:flutter/material.dart';
import 'package:test_case/src/screens/add_view.dart';
import 'package:test_case/src/screens/login_view.dart';
import 'package:test_case/src/screens/splash_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashView(),
        '/login': (context) => LoginView(),
        '/add': (context) => AddView(),
      },
    );
  }
}
