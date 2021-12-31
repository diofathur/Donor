import 'package:flutter/material.dart';
import 'settings.dart';

class ResetPage extends StatefulWidget {
  static String tag = 'reset-page';
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(SettingsPage.tag);
          },
        ),
        backgroundColor: Colors.red,
        title: Text('Reset Password'),
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(20.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: "New Password",
                    labelText: "New Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "New Password Confirm",
                    labelText: "New Password Confirm",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                ),
                RaisedButton(
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(SettingsPage.tag);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
