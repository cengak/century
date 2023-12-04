import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:century/model/globals.dart';

class OpinionSuggestion extends StatefulWidget {
  const OpinionSuggestion({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  StatefulElement createElement() {
    Global.userVar = _user.uid;
    return super.createElement();
  }

  _OpinionSuggestionState createState() => _OpinionSuggestionState();
}

class _OpinionSuggestionState extends State<OpinionSuggestion> {
  /*get scrollController => null;*/
  final TextEditingController messageText = TextEditingController();
  final TextEditingController titleText = TextEditingController();

  CollectionReference suggestionRef =
      FirebaseFirestore.instance.collection('suggestion');

  void createSuggestion() {
    final String textMessage = messageText.text.toLowerCase();

    suggestionRef.doc('${Global.userVar}').set({
      'title': '${titleText.text}',
      'sug_text': '${messageText.text}',
      'date': '${DateTime.now()}',
    });

    /* suggestionRef.add({
      'id': '${Global.userVar}',
      'date': '$date',
      'sug_text': '$textMessage',
      'user_id': '${Global.userVar}'

    });*/
  }

 /* void controlSuggestion() {
    FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('suggestion')
          .doc('${Global.userVar}')
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Bir hata oluştu!..");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          Global.msgHintText = 'Döküman bulunamadı';
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          Global.msgHintText = 'oleeey';
        }

        return Text("loading");
      },
    );
  }*/

  /*Future<void> deleteSuggestion() {
    return suggestionRef
        .doc('${Global.userVar}')
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }*/

  @override
  Widget build(BuildContext context) {
    DocumentReference<Object?> _readRef;
    _readRef = suggestionRef.doc('${Global.userVar}');
    final String _varMessage;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.amber[600],
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        /*backgroundColor: Colors.white,*/
      ),
      body: Card(
        elevation: 0,
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('suggestion')
                      .doc('${Global.userVar}')
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Bir hata oluştu!..");
                    } else if (snapshot.hasData && !snapshot.data!.exists) {
                      Global.msgHintText = 'Konu';
                      Global.ttlHintText = 'Görüş ve Önerileriniz';

                      titleText.clear();
                      messageText.clear();

                      titleText.text = '';
                      messageText.text = '';
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      Global.msgHintText = '';
                      Global.ttlHintText = '';

                      titleText.clear();
                      messageText.clear();

                      titleText.text = data['title'];
                      messageText.text = data['sug_text'];
                    }

                    return Text("");
                  },
                ),
                /**BAŞLIK**/
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: Material(
                    elevation: 5,
                    child: TextFormField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Color(0xff343434)),
                      controller: titleText,
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      decoration: InputDecoration(
                        fillColor: Colors.amber[600],
                        filled: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: '${Global.ttlHintText}',
                        hintStyle: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                /**GÖRÜŞ VE ÖNERİ**/
                Container(
                  color: Colors.amber[600],
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: Material(
                    elevation: 5,
                    child: TextFormField(
                      cursorColor: Colors.amber[600],
                      style: TextStyle(color: Colors.white),
                      controller: messageText,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        fillColor: Color(0xff343434),
                        filled: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: '${Global.msgHintText}',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
          child: FloatingActionButton(
        backgroundColor: Colors.amber[600],
        foregroundColor: Colors.white,

        //mini: true,
        onPressed: () {
          //controlSuggestion();
          createSuggestion();
          /*** deleteSuggestion();*/
        },
        child: Icon(Icons.send_outlined, color: Color(0xff343434), size: 40.0),
      )),
    );
  }
}
