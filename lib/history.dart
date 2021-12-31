import 'dart:async';
import 'dart:convert';

import 'package:donordarah/main.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class History extends StatefulWidget {
  @override
  _HistoryState createState() => new _HistoryState();
}

//State is information of the application that can change over time or when some actions are taken.
class _HistoryState extends State<History> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController date = new TextEditingController();
  static String tag = 'History';
  List datas = [];
  bool _isLoading = false;
  DateTime selectedDate = DateTime.now();

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    this.fetchData();
  }

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

  cancel(int id) async {
    // sharedPreferences.clear();
    print(id);
    var jsonResponse = null;
    Map data = {'status': "Cancel"};

    print('cek login');
    var response = await http.post(
        url_root + "/index.php?r=donor/status&id=" + id.toString(),
        body: data);
    if (response.statusCode == 200) {
      print('start');
      jsonResponse = json.decode(response.body);
      if (json.decode(response.body)['status'] != 0) {
        setState(() {
          _isLoading = false;
        });
        print("login ok");
        print(jsonResponse);

        info(context, json.decode(response.body)['message'], 0);
        print(json.decode(response.body)['message']);
        Timer(Duration(milliseconds: 3300), () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => History()),
              (Route<dynamic> route) => false);
        });
      } else {
        print('gagal');
        info(context, json.decode(response.body)['message'], 0);
        print(json.decode(response.body)['message']);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  reschedule(String tgl, int id) async {
    // sharedPreferences.clear();
    print(id);
    var jsonResponse = null;
    Map data = {'tanggal': tgl};

    print('cek login');
    var response = await http.post(
        url_root + "/index.php?r=donor/reschedule&id=" + id.toString(),
        body: data);
    if (response.statusCode == 200) {
      print('start');
      jsonResponse = json.decode(response.body);
      if (json.decode(response.body)['status'] != 0) {
        setState(() {
          _isLoading = false;
        });
        print("login ok");
        print(jsonResponse);
        info(context, json.decode(response.body)['message'], 0);
        print(json.decode(response.body)['message']);
        Timer(Duration(milliseconds: 3300), () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => History()),
              (Route<dynamic> route) => false);
        });
      } else {
        print('gagal');
        info(context, json.decode(response.body)['message'], 0);
        print(json.decode(response.body)['message']);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  void info(BuildContext context, String status, int sts) {
    // _scaffoldKey.currentState.showSnackBar(SnackBar(
    //   content: Text(status),
    //   backgroundColor: Colors.red,
    //   duration: Duration(seconds: 3),
    // ));
    Flushbar(
      duration: Duration(seconds: 3),
      borderRadius: 8,
      backgroundGradient: sts == null
          ? LinearGradient(
              colors: [Colors.red.shade800, Colors.redAccent.shade700],
              stops: [0.6, 1],
            )
          : LinearGradient(
              colors: [Colors.green.shade800, Colors.greenAccent.shade700],
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
      title: 'Info!',
      message: status,
    ).show(context);
  }

  Future fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = (prefs.getInt('id') ?? false);
    print(id);
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(url_root + "index.php?r=donor/get&id=" + id.toString());
    print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['data'];
      setState(() {
        datas = items;
        isLoading = false;
      });
    } else {
      datas = [];
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return new Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(DashboardScreen.tag);
            },
          ),
          title: new Text('History'),
          backgroundColor: Colors.red,
        ),
        //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
        body: ListView.builder(
            itemCount: datas.length,
            itemBuilder: (context, index) {
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 15.0,
                          child: new Text(
                            datas[index]['no_antrian'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      title: Text(
                        datas[index]['nama'] ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "Usia : " +
                                datas[index]['usia'].toString() +
                                " | Gol : " +
                                datas[index]['golongan_darah'] +
                                "\n" +
                                datas[index]['tanggal'] ??
                            "",
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                      trailing: Text(
                        datas[index]['status'] ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                    ),
                    datas[index]['status'] == 'Active'
                        ? ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (_) => Dialog(
                                      child: Form(
                                        key: _formKey,
                                        child: Container(
                                          height: size.height * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Tanggal Donor : ",
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.05,
                                                ),
                                                TextFormField(
                                                  controller: date,
                                                  decoration:
                                                      new InputDecoration(
                                                    // enabled: false,
                                                    hintText: "Tanggal Donor",
                                                    labelText: "Tanggal Donor",
                                                    suffixIcon: IconButton(
                                                      onPressed: () =>
                                                          _selectDate(context),
                                                      icon: Icon(
                                                          Icons.calendar_today),
                                                    ),
                                                    border:
                                                        new OutlineInputBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    20.0)),
                                                  ),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                  },
                                                ),
                                                Padding(
                                                    padding:
                                                        new EdgeInsets.only(
                                                  top: 20.0,
                                                )),
                                                FlatButton(
                                                  textColor:
                                                      const Color(0xFF6200EE),
                                                  onPressed: () async {
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      setState(() {
                                                        _isLoading = true;
                                                      });
                                                      reschedule(
                                                          date.text,
                                                          datas[index]
                                                              ['id_donor']);
                                                    }
                                                  },
                                                  child:
                                                      const Text('RESCHEDULE'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('RESCHEDULE'),
                              ),
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () {
                                  cancel(datas[index]['id_donor']);
                                },
                                child: const Text('CANCEL'),
                              ),
                            ],
                          )
                        : Text(datas[index]['status'] ?? ""),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                    ),
                  ],
                ),
              );
            }));
  }
}
