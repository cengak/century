import 'package:century/Pages/ListRead//readingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ReadingListPage extends StatelessWidget {
  //get _fireStore => FirebaseFirestore.instance;
  const ReadingListPage(
      {Key? key, required this.centuryId, required this.pageId})
      : super(key: key);
  //update the constructor to include the uid
  final String centuryId;
  final String pageId;

  Widget build(BuildContext context) {
    CollectionReference centuryRef =
        FirebaseFirestore.instance.collection('$pageId');

    return Scaffold(
      backgroundColor: Color(0xff343434),
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        title: Text('$centuryId $pageId'),
      ),
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          /*** Widget ***/
          children: <Widget>[
            StreamBuilder(
              stream: centuryRef
                  .where("century", isEqualTo: "$centuryId")
                  //.orderBy('year')
                  .snapshots(),

              //.orderBy(FieldPath.documentId)
              //.orderBy('mil_id', descending: true)

              builder:
                  (BuildContext context, AsyncSnapshot centuryAsyncSnapshot) {
                if (centuryAsyncSnapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<DocumentSnapshot> listOfCenturySnapshot =
                    centuryAsyncSnapshot.data.docs;

                if (listOfCenturySnapshot.length < 1) {
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
                      itemCount: listOfCenturySnapshot.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                              title: Text('${listOfCenturySnapshot[index].get('title')}',
                                  style: TextStyle(
                                    fontSize: 24,
                                  )),
                              subtitle: Text('${listOfCenturySnapshot[index].get('year')}',
                                style: TextStyle(
                                fontSize: 20,
                              )),
                              trailing: Icon(Icons.read_more,
                                  color: Color(0xffFFFFB300), size: 40.0),
                              //leading: const Icon(Icons.history),
                              onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ReadingPage(pageSelectId: pageId, readingId: listOfCenturySnapshot[index].id),),),
                        ));


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
