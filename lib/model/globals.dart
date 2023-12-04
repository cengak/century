import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Global{
  static String pageId = '';
  static String readingId = '';
  static String msgHintText = '';
  static String ttlHintText = '';
  static var userVar = '1';

}
/*void controlSuggestion(){
  FutureBuilder<DocumentSnapshot>(
    future: FirebaseFirestore.instance.collection('suggestion').doc('${Global.userVar}').get(),

    builder:
        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {


      if (snapshot.hasError) {
        return Text("Bir hata oluştu!..");

      }

      if (snapshot.hasData && !snapshot.data!.exists) {
        Global.msgHintText ='Döküman bulunamadı';
      }

      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        Global.msgHintText ='oleeey';

      }

      return Text("loading");


    },
  );
}*/
