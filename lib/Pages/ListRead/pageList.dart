import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:century/Pages/ListRead/readingList.dart';

class PagesPage extends StatelessWidget {
  //get _fireStore => FirebaseFirestore.instance;
  const PagesPage({Key? key, required String centuryID})
      : centuryID = centuryID,
        super(key: key);
  final String centuryID;

  Widget build(BuildContext context) {
    CollectionReference pagesRef =
        FirebaseFirestore.instance.collection('pages');

    return Scaffold(
      backgroundColor: Color(0xff343434),
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        title: Text('${centuryID}'),
      ),
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          /*** Widget ***/
          children: <Widget>[
            StreamBuilder(
              stream: pagesRef.snapshots(),

              //.orderBy(FieldPath.documentId)
              //.orderBy('mil_id', descending: true)

              builder:
                  (BuildContext context, AsyncSnapshot pagesAsyncSnapshot) {
                if (pagesAsyncSnapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<DocumentSnapshot> listOfPagesSnapshot =
                    pagesAsyncSnapshot.data.docs;

                if (listOfPagesSnapshot.length < 1) {
                  return Text(
                    "Bu bölüme henüz veri girilmemiş.",
                    style: TextStyle(
                      height: 12,
                      fontSize: 24,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                      decorationStyle: TextDecorationStyle.wavy,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return Flexible(
                    child: ListView.builder(
                      itemCount: listOfPagesSnapshot.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                              title: Text('${listOfPagesSnapshot[index].id}',
                                  style: TextStyle(
                                    fontSize: 24,
                                  )),
                              /*leading: const Icon(Icons.read_more,
                                  color: Color(0xffFFFFB300), size: 40.0),*/
                              trailing: Icon(Icons.read_more,
                                  color: Color(0xffFFFFB300), size: 40.0),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ReadingListPage(
                                          centuryId: centuryID,
                                          pageId: listOfPagesSnapshot[index]
                                              .get('col_id'),
                                        )));
                              }),
                        );

                        //Text('${listOfDocumentSnapshot[index].get('mil_id')}  asdf1');
                      },
                    ),
                  );
                }
//Text('${asyncSnapshot.data.data()}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
