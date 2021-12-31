import 'dart:convert';

import 'package:donordarah/main.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';

  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController username = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
   bool _isLoading = false;
  signup(String username,email, pass) async {
    // sharedPreferences.clear();
    Map data = {'username': username,'email': email, 'password': pass};
    var jsonResponse = null;
    print('cek login');
    var response = await http.post(url_root + "/index.php?r=auth/signup", body: data);
    if (response.statusCode == 200) {
      print('start');
      jsonResponse = json.decode(response.body);
      if (json.decode(response.body)['status'] != 0) {
        setState(() {
          _isLoading = false;
        });
        print("login ok");
        print(jsonResponse);
        
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
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
    final usernames = TextFormField(
      controller: username,
      keyboardType: TextInputType.name,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
       validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                  },
    );
    final emails = TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
       validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                  },
    );

    final passwords = TextFormField(
      controller: password,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
       validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                  },
    );

    final registButton = Padding(
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
            signup(username.text,email.text, password.text);
          }
          },
          color: Colors.red,
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
            onPressed: () {
            Navigator.of(context).pushNamed(LoginPage.tag);
          },
        ),
        backgroundColor: Colors.red,
        title: Text('Register'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey, 
                  child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height: 8.0),
              usernames,
              SizedBox(height: 8.0),
              emails,
              SizedBox(height: 8.0),
              passwords,
              SizedBox(height: 24.0),
              registButton,
            ],
          ),
        ),
      ),
    );
  }
}
