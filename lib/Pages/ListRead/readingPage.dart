import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:century/Pages/ListRead//centuryList.dart';
import 'package:flutter/painting.dart';
import 'package:century/Pages/Note/takingNotePage.dart';
import 'package:century/model/globals.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage(
      {Key? key, required this.pageSelectId, required this.readingId})
      : super(key: key);

  //update the constructor to include the uid
  final String pageSelectId;
  final String readingId;

  @override
  Widget build(BuildContext context) {
    Global.pageId = pageSelectId;
    Global.readingId = readingId;

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
            builder: (context) => TakingNote(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference _centuryRef;
    _centuryRef = FirebaseFirestore.instance.collection('${Global.pageId}');
    DocumentReference<Object?> _readRef;
    _readRef = _centuryRef.doc('${Global.readingId}');

    //final fireStoreRef = FirebaseStorage.instance.ref().child('${Global.readingId}.jpeg');
// no need of the file extension, the name will do fine.

    return FutureBuilder<DocumentSnapshot>(
      future: _readRef.get(),
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
              actions: <Widget>[
                IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.amber[600],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => CenturyPage(
                          millenniumId: 'M.S. 1. Binyıl',
                        ),
                      ),
                    );
                  },
                )
              ],
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
                        /**NETWORK IMAGE**/
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 10,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 7), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
                          child: Image.network('${data['image']}'),
                        ),

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
                                  text: "  ${data['detail']}  ",
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
                  onPressed: () {},
                  child: Icon(Icons.add_box_outlined,
                      color: Color(0xff343434), size: 40.0),
                )),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        }

        return Text("loading");
      },
    );
  }
}
