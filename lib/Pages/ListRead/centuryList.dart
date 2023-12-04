import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:century/Pages/ListRead/pageList.dart';

class CenturyPage extends StatelessWidget {
  //get _fireStore => FirebaseFirestore.instance;
  const CenturyPage({Key? key, required String millenniumId})
      : millenniumId = millenniumId,
        super(key: key);
  final String millenniumId;

  Widget build(BuildContext context) {
    CollectionReference centuryRef =
        FirebaseFirestore.instance.collection('centuries');

    return Scaffold(
      backgroundColor: Color(0xff343434),
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        title: Text('${millenniumId}'),
      ),
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          /*** Widget ***/
          children: <Widget>[
            StreamBuilder(
              stream: centuryRef
                  .where("mil_id", isEqualTo: "${millenniumId}")
                  .orderBy('cen_id')
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
                      decorationColor: Colors.red[900],
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
                              title: Text('${listOfCenturySnapshot[index].id}',
                                  style: TextStyle(
                                    fontSize: 24,
                                  )),
                              trailing: Icon(Icons.read_more,
                                  color: Color(0xffFFFFB300), size: 40.0),
                              //leading: const Icon(Icons.history),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PagesPage(
                                            centuryID:
                                                listOfCenturySnapshot[index]
                                                    .id)));
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
