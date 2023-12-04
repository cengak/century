/*import 'dart:html';*/

import 'package:century/model/jsonRead.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:century/Pages/ListRead/centuryList.dart';
import 'package:century/Pages/modules/info.dart';
import 'package:century/Pages/modules/furtherReading.dart';
import 'package:century/Pages/Authentication/user_info_screen.dart';
import 'package:century/Pages/OptinionSuggestion/opinionSuggestionPage.dart';
import 'package:flutter/painting.dart';
import 'package:century/Pages/OptinionSuggestion/opinionSuggestionList.dart';
import 'package:century/Pages/modules/suggestionBookEdit.dart';

class Home extends StatelessWidget {
  get _fireStore => FirebaseFirestore.instance;

  const Home({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  Widget build(BuildContext context) {
    CollectionReference millenniumRef = _fireStore.collection('millennium');
    final Future<SuggestionBook> suggestionBook = readBookJson();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        title: Text('Anasayfa'),
        // color:Colors.amber[600],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        color: Color(0xff343434),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(7, 7, 7, 0),
                          height: 50,
                          color: Colors.amber[600],
                          child: Container(
                            margin: EdgeInsets.fromLTRB(7, 7, 7, 7),
                            child: Center(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FlatButton(
                                      child: Container(
                                        height: 40,
                                        color: Colors.amber[600],
                                        child: Text(
                                          'Haftanın Kitap Önerisi',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      onPressed: () {
                                        if ('WoQ06ZugfMZvtHNFHDftIkakw302' ==
                                            _user.uid) {
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                CreateBookSuggestion(),
                                          ));
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder<SuggestionBook>(
                future: suggestionBook,
                builder: (context, snapshot) {


                  // By default, show a loading spinner.
                  return Row(children: [
                    Expanded(
                      child: Container(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
                          color: Color(0xff343434),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(7, 0, 7, 7),
                            color: Colors.amber,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(7, 0, 7, 7),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 17, bottom: 0),
                                                child: Text(
                                                  '${snapshot.data!.bookTitle}',
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 24,
                                                  ),
                                                  overflow: TextOverflow.clip,
                                                  maxLines: null,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 0, right: 15),
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerRight,
                                                  child: Text(
                                                    '',
                                                    overflow:
                                                    TextOverflow.clip,
                                                    maxLines: null,
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontStyle:
                                                      FontStyle.italic,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 0, 10, 10),
                                                child: Image.network(
                                                    '${snapshot.data!.imgURL}'),
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    right: 10,
                                                    left: 10),
                                                width: 200,
                                                child: Text(
                                                  ' "${snapshot.data!.bookDetail}" ',
                                                  overflow: TextOverflow.clip,
                                                  maxLines: null,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]);

                },
              ),
              StreamBuilder(
                stream: millenniumRef.snapshots(),
                //.orderBy('mil_id', descending: true)

                builder: (BuildContext context,
                    AsyncSnapshot millenniumAsyncSnapshot) {
                  if (millenniumAsyncSnapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<DocumentSnapshot> listOfMillenniumSnapshot =
                      millenniumAsyncSnapshot.data.docs;
                  return Flexible(
                    child: ListView.builder(
                      itemCount: listOfMillenniumSnapshot.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                              title: Text(
                                  '${listOfMillenniumSnapshot[index].get('mil_id')} ',
                                  style: TextStyle(
                                    fontSize: 24,
                                  )),
                              //leading: const Icon(Icons.history),
                              trailing: Icon(Icons.read_more,
                                  color: Color(0xffFFFFB300), size: 40.0),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          CenturyPage(
                                              millenniumId:
                                                  listOfMillenniumSnapshot[
                                                          index]
                                                      .get('mil_id'))),
                                );
                              }),
                        );

                        //Text('${listOfDocumentSnapshot[index].get('mil_id')}  asdf1');
                      },
                    ),
                  );
//Text('${asyncSnapshot.data.data()}');
                },
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset(
                'assets/C1.png',
              ),
              decoration: BoxDecoration(
                color: Color(0xffFFFFB300),
              ),
            ),
            ListTile(
              title: Text('Anasayfa'),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
                title: Text('Hakkında'),
                leading: const Icon(Icons.info),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Information()));
                }),
            ListTile(
                title: Text('İleri Okuma'),
                leading: const Icon(Icons.read_more),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FurtherRead()));
                }),
            ListTile(
                title: Text('Görüş&Öneri'),
                leading: const Icon(Icons.info),
                onTap: () {
                  if ('WoQ06ZugfMZvtHNFHDftIkakw302' == _user.uid) {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OpinionSuggestion(
                        user: _user,
                      ),
                    ));
                  } else {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OpinionSuggestionList(),
                    ));
                  }
                }),

            /*ListTile(
                title: Text('Görüş&Öneri Oku'),
                leading: const Icon(Icons.info),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OpinionSuggestionList(),
                  ));
                }
                ),*/

            /*ListTile(
              title: Text('extends'),
              leading: const Icon(Icons.account_box),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SQLiteMyHomePage(),
                ),
              ),
            ),*/
            ListTile(
              title: Text('Kullanıcı'),
              leading: const Icon(Icons.account_box),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserInfoScreen(
                    user: _user,
                  ),
                ),
              ),
            ),

            /* ListTile(
              title: Text('Not Alma'),
              leading: const Icon(Icons.account_box),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EleventhCentury(),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
