import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'daftar.dart';
import 'history.dart';
import 'settings.dart';
import 'about.dart';

class DashboardScreen extends StatefulWidget {
  static String tag = 'dashboard-screen';
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  int id_user;
  String username;

  @override
  void initState() {
    super.initState();
    _getId();
    _getUsername();
  }
String result = "Hey there !";
  Future<int> _getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    setState(() {
      id_user = (prefs.getInt('id') ?? false);
    });
  }
  Future<String> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username') ?? false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text('Donor Darah'),
      ),
      body: IconTheme.merge(
        data: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(Icons.person, size: 72.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Selamat Datang',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('$username'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 1.0),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: new MaterialButton(
                        height: 150.0,
                        minWidth: 150.0,
                        color: Colors.red,
                        textColor: Colors.white,
                        child: new Text("Daftar Donor"),
                        onPressed: ()=>{
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Daftar(),)
                          )
                        },
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: new MaterialButton(
                      height: 150.0,
                      minWidth: 150.0,
                      color: Colors.red,
                      textColor: Colors.white,
                      child: new Text("History"),
                      onPressed: ()=>{
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context)=> History(),))
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: new MaterialButton(
                      height: 150.0,
                      minWidth: 150.0,
                      color: Colors.red,
                      textColor: Colors.white,
                      child: new Text("About Us"),
                      onPressed: ()=>{
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context)=> AboutPage(),))
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: new MaterialButton(
                      height: 150.0,
                      minWidth: 150.0,
                      color: Colors.red,
                      textColor: Colors.white,
                      child: new Text("Settings"),
                      onPressed: ()=>{
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context)=> SettingsPage(),))
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

