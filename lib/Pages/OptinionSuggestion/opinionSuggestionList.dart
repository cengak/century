import 'package:century/Pages/OptinionSuggestion/opinionSuggestionRead.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class OpinionSuggestionList extends StatelessWidget {
  //get _fireStore => FirebaseFirestore.instance;



  Widget build(BuildContext context) {
    /** Firebase Collection'a bağlanma **/
    CollectionReference centuryRef =
    FirebaseFirestore.instance.collection('suggestion');

    return Scaffold(
      backgroundColor: Color(0xff343434),
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        title: Text('Görüş ve Öneriler'),
      ),
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          /*** Widget ***/
          children: <Widget>[
            /** firebase veri akışını dinleme **/
            StreamBuilder(
              stream: centuryRef
                  .orderBy('date', descending: true)
                  .snapshots(),

              //.orderBy(FieldPath.documentId)
              //.orderBy('mil_id', descending: true)
              /** Firebase Collectiondan çekilen verinin listeye aktarılması **/
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
                    /** Liste aktarılan verinin yazdırılması**/
                    child: ListView.builder(
                      itemCount: listOfCenturySnapshot.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                              title: Text('${listOfCenturySnapshot[index].get('title')}',
                                  style: TextStyle(
                                    fontSize: 24,
                                  )),

                              trailing: Icon(Icons.read_more,
                                  color: Color(0xffFFFFB300), size: 40.0),
                              //leading: const Icon(Icons.history),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OsReadingPage(oSreadingId: '${listOfCenturySnapshot[index].id}',),),
                              ),
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
