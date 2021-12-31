import 'dart:convert';

import 'package:donordarah/main.dart';
import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';
import 'regist.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController username = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  bool _isLoading = false;
  signIn(String username, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.clear();
    Map data = {'username': username, 'password': pass};
    var jsonResponse = null;
    print('cek login');
    var response = await http.post(url_root + "/index.php?r=auth/login", body: data);
    if (response.statusCode == 200) {
      print('start');
      jsonResponse = json.decode(response.body);
      if (json.decode(response.body)['status'] != 0) {
        setState(() {
          _isLoading = false;
        });
        print("login ok");
        print(jsonResponse);
        sharedPreferences.setInt("status_login", jsonResponse['status']);
        sharedPreferences.setString("message", jsonResponse['message']);
        sharedPreferences.setInt("id", jsonResponse['user']['id']);
        sharedPreferences.setString("email", jsonResponse['user']['email']);
        sharedPreferences.setString("username", jsonResponse['user']['username']);
        sharedPreferences.setString("level", jsonResponse['user']['level']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => DashboardScreen()),
            (Route<dynamic> route) => false);
      } else {
        print('gagal');
        info(context, json.decode(response.body)['message']);
        print(json.decode(response.body)['message']);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  void info(BuildContext context, String status) {
    // _scaffoldKey.currentState.showSnackBar(SnackBar(
    //   content: Text(status),
    //   backgroundColor: Colors.red,
    //   duration: Duration(seconds: 3),
    // ));
    Flushbar(
      duration: Duration(seconds: 3),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
        colors: [Colors.red.shade800, Colors.redAccent.shade700],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      // All of the previous Flushbars could be dismissed by swiping down
      // now we want to swipe to the sides
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      // The default curve is Curves.easeOut
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: 'Login Error!',
      message: status,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Column(
      children: <Widget>[
        Image.asset('assets/BLOOD1.png'),
      ],
    );

    final email = TextFormField(
       validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      // keyboardType: TextInputType.emailAddress,
      controller: username,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final passwords = TextFormField(
       validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      autofocus: false,
      controller: password,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
             if (_formKey.currentState.validate()) {
            setState(() {
              _isLoading = true;
            });
            signIn(username.text, password.text);
          }
          },
          color: Colors.red,
          child: Text(
            'Log In',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );


    final regisLabel = FlatButton(
      padding: EdgeInsets.all(20.0),
      child: Text(
        'Register',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(RegisterPage.tag);
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
                  child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              passwords,
              SizedBox(height: 24.0),
              loginButton,
              regisLabel
            ],
          ),
        ),
      ),
    );
  }
}
