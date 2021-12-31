import 'dart:convert';

import 'package:donordarah/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  static String tag = 'profile-page';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showPassword = false;
  
  @override
  void initState() {
    super.initState();
    this._fetchData();
  }

  Map data;
  List userData;
  String username='';
  String email='';
  var isLoading = false;

  Future _fetchData() async {
    print("fetch");
    // print(todo);
     SharedPreferences prefs = await SharedPreferences.getInstance();
     int id = (prefs.getInt('id') ?? false);
     print(id);
    var jsonResponse = null;
    final response =
        await http.get(url_root + "index.php?r=auth/view&id="+id.toString());
    print(response.statusCode);
    jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      print('start');
      jsonResponse = json.decode(response.body);
      // if (json.decode(response.body)['status'] != 0) {

      print("login ok");
      setState(() {
        username = jsonResponse["username"];
        email = jsonResponse["email"];
        // nosewa = jsonResponse["data"]["no_sewa"];
      });
      print("list");
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(SettingsPage.tag);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            buildTextField("Username", "$username", false),
            buildTextField("E-mail", "$email", false),
            // buildTextField("Password", "", true),
            // buildTextField("Location", "", false),
            SizedBox(
              height: 35,
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            //   children: [
            //     RaisedButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => SettingsPage()),
            //         );
            //       },
            //       color: Colors.red,
            //       padding: EdgeInsets.symmetric(horizontal: 50),
            //       elevation: 2,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20)),
            //       child: Text(
            //         "SAVE",
            //         style: TextStyle(
            //             fontSize: 14, letterSpacing: 2.2, color: Colors.white),
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
