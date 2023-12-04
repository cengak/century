import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:century/model/globals.dart';

import 'opinionSuggestionList.dart';
import 'opinionSuggestionPage.dart';

class OsReadingPage extends StatelessWidget {
  const OsReadingPage(
      {Key? key, required this.oSreadingId})
      : super(key: key);

  //update the constructor to include the uid

  final String oSreadingId;

  @override
  Widget build(BuildContext context) {

    Global.readingId = oSreadingId;

    return Scaffold(
      body: MainContent(),
    );
  }
}

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  get scrollController => null;

  void _onVerticalDragStartHandler(DragStartDetails details) {
    setState(
          () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => OpinionSuggestionList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference suggestionRef =
    FirebaseFirestore.instance.collection('suggestion');


    CollectionReference _oSRef;
    _oSRef = FirebaseFirestore.instance.collection('suggestion');
    DocumentReference<Object?> _oSreadRef;
    _oSreadRef = _oSRef.doc('${Global.readingId}');

    Future<void> deleteSuggestion() {
    return suggestionRef
        .doc('${Global.readingId}')
        .delete()
        .then((value) => print("Silindi!.."))
        .catchError((error) => print("Silinirken hata oluştu!: $error"));
  }
    //final fireStoreRef = FirebaseStorage.instance.ref().child('${Global.readingId}.jpeg');
// no need of the file extension, the name will do fine.

    return FutureBuilder<DocumentSnapshot>(
      future: _oSreadRef.get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Bir hata oluştu!..");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Veritabanına bağlanılamadı!..");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            backgroundColor: Color(0xff343434),
            appBar: AppBar(

              elevation: 0,
              backgroundColor: Color(0xff343434),
              /*backgroundColor: Colors.white,*/
            ),
            body: Card(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Center(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [


                        /**BAŞLIK**/
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${data['title']}',
                                  style: TextStyle(
                                    color: Color(0xff343434),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        /**İÇERİK**/
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "  ${data['sug_text']}  ",
                                  style: TextStyle(
                                    color: Color(0xff343434),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: GestureDetector(
                onVerticalDragStart: _onVerticalDragStartHandler,
                child: FloatingActionButton(
                  backgroundColor: Colors.amber[600],
                  foregroundColor: Colors.white,

                  //mini: true,
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Dikkat!..'),
                      content: const Text('Mesajı silmek istediğinizden emin misiniz?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('İptal'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'OK');
                            deleteSuggestion();
                            MaterialPageRoute(
                              builder: (context) => OpinionSuggestionList(),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text('Tamam'),
                        ),
                      ],
                    ),
                  ),
                  child: Icon(Icons.delete,
                      color: Color(0xff343434), size: 40.0),
                )
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        }

        return Text("loading");
      },
    );
  }
}
