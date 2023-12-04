import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TakingNote extends StatelessWidget {
  get scrollController => null;

  @override
  Widget build(BuildContext context) {
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
            /** onTap: () {
                Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                builder: (context) => ReadingPage(),
                ),
                );
                } **/
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
          child: Column(
            children: [
              /**BAŞLIK**/
              Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: Material(
                  elevation: 0,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Başlık',
                      hintStyle: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              /**NOT**/
              Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: Material(
                  elevation: 0,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Not Almaya Başlayın',
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
      floatingActionButton: GestureDetector(
          child: FloatingActionButton(
        backgroundColor: Colors.amber[600],
        foregroundColor: Colors.white,

        //mini: true,
        onPressed: () {},
        child: Icon(Icons.save, color: Color(0xff343434), size: 40.0),
      )),
    );
  }
}
