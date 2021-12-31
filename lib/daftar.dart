import 'dart:convert';

import 'package:donordarah/history.dart';
import 'package:donordarah/main.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';
import 'package:http/http.dart' as http;

class Daftar extends StatefulWidget {
  static String tag = 'daftar';
  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController usia = new TextEditingController();
  final TextEditingController tb = new TextEditingController();
  final TextEditingController bb = new TextEditingController();
  final TextEditingController date = new TextEditingController();
  String _jk = "";

  List<String> golongan = ["A", "B", "AB", "O"];
  String _golongan = "A";

  int id_user;
  String emailuser;
  

  _pilihJk(value) {
    setState(() {
      _jk = value;
    });
  }

  void golonganDarah(value) {
    setState(() {
      _golongan = value;
    });
  }

  // void tanggalan(value) {
  //   setState(() {
  //     _tanggal = value;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _getId();
    _getEmailuser();
  }

  String result = "Hey there !";
  Future<int> _getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    setState(() {
      id_user = (prefs.getInt('id') ?? false);
    });
  }

  Future<String> _getEmailuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailuser = (prefs.getString('email') ?? false);
    });
  }

  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 2)),
      firstDate: DateTime.now().add(Duration(days: 2)),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        date.text = picked.toString().replaceAll(' 00:00:00.000', '');
      });
    print(selectedDate);
  }

  bool _isLoading = false;
  signup(String nama, usia, jk, tb, bb, golonganDarah, tgl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = (prefs.getInt('id') ?? false);
    print(id);
    Map data = {
      'id_user': id.toString(),
      'nama': nama,
      'usia': usia,
      'jk': jk,
      'tinggi_badan': tb,
      'berat_badan': bb,
      'golongan_darah': golonganDarah,
      'tanggal': tgl
    };
    print(data);
    var jsonResponse = null;
    print('cek login');
    var response =
        await http.post(url_root + "/index.php?r=donor/post", body: data);
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
            MaterialPageRoute(builder: (BuildContext context) => History()),
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
    email.text = emailuser;
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
        title: Text('Regist'),
      ),
      body: Form(
        key: _formKey,
        child: new ListView(
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.all(20.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new TextFormField(
                    controller: name,
                    decoration: new InputDecoration(
                      hintText: "Nama",
                      labelText: "Nama",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 20.0),
                  ),
                  new TextFormField(
                    controller: email,
                    enabled: false,
                    decoration: new InputDecoration(
                      hintText: "Email",
                      labelText: "Email",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 20.0),
                  ),
                  // new TextField(
                  //   decoration: new InputDecoration(
                  //     hintText: "No Telepon",
                  //     labelText: "No Telepon",
                  //     border: new OutlineInputBorder(
                  //         borderRadius: new BorderRadius.circular(20.0)),
                  //   ),
                  // ),
                  // new Padding(
                  //   padding: new EdgeInsets.only(top: 20.0),
                  // ),
                  new RadioListTile(
                    value: "Laki-laki",
                    title: new Text('Laki-laki'),
                    groupValue: _jk,
                    onChanged: (value) {
                      _pilihJk(value);
                    },
                    activeColor: Colors.red,
                  ),
                  new RadioListTile(
                    value: "Perempuan",
                    title: new Text('Perempuan'),
                    groupValue: _jk,
                    onChanged: (value) {
                      _pilihJk(value);
                    },
                    activeColor: Colors.red,
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 20.0),
                  ),
                  new TextFormField(
                    controller: usia,
                    decoration: new InputDecoration(
                      hintText: "Usia",
                      labelText: "Usia",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 20.0),
                  ),
                  new TextFormField(
                    controller: tb,
                    decoration: new InputDecoration(
                      hintText: "Tinggi Badan",
                      labelText: "Tinggi Badan",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 20.0),
                  ),
                  new TextFormField(
                    controller: bb,
                    decoration: new InputDecoration(
                      hintText: "Berat Badan",
                      labelText: "Berat Badan",
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 20.0),
                  ),
                  new Row(
                    children: <Widget>[
                      new Text(
                        "Golongan Darah",
                        style:
                            new TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      Padding(
                          padding: new EdgeInsets.symmetric(horizontal: 20.0)),
                      new DropdownButton(
                        onChanged: (value) {
                          golonganDarah(value);
                        },
                        value: _golongan,
                        items: golongan.map((String value) {
                          return new DropdownMenuItem(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.0,
                    ),
                  ),
                  new TextFormField(
                    controller: date,
                    decoration: new InputDecoration(
                      // enabled: false,
                      hintText: "Tanggal Donor",
                      labelText: "Tanggal Donor",
                      suffixIcon: IconButton(
                        onPressed: () => _selectDate(context),
                        icon: Icon(Icons.calendar_today),
                      ),
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 20.0),
                  ),

                  Padding(
                      padding: new EdgeInsets.only(
                    top: 20.0,
                  )),
                  new RaisedButton(
                    child: new Text("Daftar",
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        signup(name.text, usia.text, _jk, tb.text, bb.text,
                            _golongan, date.text);
                      }
                    },
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
