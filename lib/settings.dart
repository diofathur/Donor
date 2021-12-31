import 'package:donordarah/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';
import 'login.dart';
import 'profile.dart';
import 'resetpass.dart';

class SettingsPage extends StatefulWidget {
  static String tag = 'settings-page';
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(DashboardScreen.tag);
          },
        ),
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(20.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Profile'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()),
                            );
                          },
                        ),
                        Divider(
                          height: 30,
                          color: Colors.black,
                        ),
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text(
                            'Log Out',
                            style: TextStyle(color: Colors.red),
                          ),
                          onTap: () async {
                // Future logout() async {
                  // timer.cancel();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                //  runApp(MyApp());
                // Navigator.push(
                //         context,
                //         new MaterialPageRoute(
                //             builder: (BuildContext context) => new MyApp()));
                Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext context) => MyApp()),
                        (Route<dynamic> route) => false);
                // exit(0);
                // }
              },
                        ),
                        Divider(height: 30, color: Colors.black),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
