import 'package:flutter/material.dart';
import 'dashboard.dart';

class AboutPage extends StatefulWidget {
  static String tag = 'about-page';
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: Text('About Us'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed(DashboardScreen.tag);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Card(
                child: new Column(
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.all(30.0),
                      child: new Image.network(
                          'https://www.pmikabjember.com/assets/template/front/images/logo_pmi.png',
                          fit: BoxFit.fill),
                    ),
                  ],
                ),
              ),
              new Card(
                child: new Column(
                  children: <Widget>[
                    new Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Palang Merah Indonesia adalah sebuah organisasi perhimpunan nasional di indonesia yang bergerak dalam bidang sosial kemanusiaan',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    new Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'PMI selalu mempunyai 7 (tujuh) prinsip dasar gerakan Internasional Palang Merah dan Bulan Sambit Merah yaitu Kemanusiaan, Kesamaan, Kesukarelaan, Kemandirian, Kesatuan, Kenetralan, dan Kesemestaan.',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
              ),
              new Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
                color: Colors.black54,
                child: new Column(
                  children: <Widget>[
                    new Text(
                      'Contact Us',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    new ListTile(
                      title: Text(
                        'Jl. Jend. Gatot Subroto Kav. 96 Jakarta',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      leading:
                          Icon(Icons.home, color: Colors.white, size: 16.0),
                    ),
                    new ListTile(
                      title: Text(
                        '021 7992325',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      leading:
                          Icon(Icons.phone, color: Colors.white, size: 16.0),
                    ),
                    new ListTile(
                      title: Text(
                        'pmi@pmi.or.id',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      leading:
                          Icon(Icons.mail, color: Colors.white, size: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
