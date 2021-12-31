import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about.dart';
import 'daftar.dart';
import 'dashboard.dart';
import 'login.dart';
import 'regist.dart';
import 'settings.dart';

void main() => runApp(MyApp());

String url_root = 'http://192.168.43.50/donor/frontend/web/';
String url_asset = 'https://api-donor.mch.my.id/';

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<MyApp> {
  int id_user;
  int status;

  @override
  void initState() {
    super.initState();
    _getId();
  }

  String result = "Hey there !";
  Future<int> _getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    setState(() {
      id_user = (prefs.getInt('id') ?? false);
    });
  }

  Future<int> _getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      status = (prefs.getInt('status_login') ?? false);
    });
  }

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    DashboardScreen.tag: (context) => DashboardScreen(),
    Daftar.tag: (context) => Daftar(),
    RegisterPage.tag: (context) => RegisterPage(),
    SettingsPage.tag: (context) => SettingsPage(),
    AboutPage.tag: (context) => AboutPage(),
  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (id_user != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DashboardScreen(),
        routes: routes,
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
        routes: routes,
      );
    }
  }
}
