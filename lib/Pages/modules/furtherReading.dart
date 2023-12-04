import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FurtherRead extends StatelessWidget {
  get scrollController => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff343434),
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        title: Text('İleri Okuma'),
      ),
      body: Card(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white10,
            // border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Wikipedia Tarih Portalı',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onLongPress: () {
                      launch('https://tr.wikipedia.org/wiki/Portal:Tarih');

                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Arkeofili',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onLongPress: () {
                      launch('https://arkeofili.com/');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Evrim Ağacı',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onLongPress: () {
                      launch('https://evrimagaci.org/');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Arkeo-Tr',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onLongPress: () {
                      launch('https://www.arkeo-tr.com/');
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
