import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<Book> createBook(
    String bookTitle, String bookDetail, String bookURL, String imgURL) async {
  final response = await http.post(
    Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/century-de709.appspot.com/o/books.json?alt=media&token=d590725e-fc5f-40fd-b647-3d93b7702cd7'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'bookTitle': bookTitle,
      'bookDetail': bookDetail,
      'bookURL': bookURL,
      'imgURL': imgURL,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Book.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Kitap kaydı oluşturulamadı.');
  }
}

class Book {
  final String bookTitle;
  final String bookDetail;
  final String bookURL;
  final String imgURL;

  Book({
    required this.bookTitle,
    required this.bookDetail,
    required this.bookURL,
    required this.imgURL,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bookTitle: json['bookTitle'],
      bookDetail: json['bookDetail'],
      bookURL: json['bookURL'],
      imgURL: json['this.imgURL'],
    );
  }
}

void main() {
  runApp(CreateBookSuggestion());
}

class CreateBookSuggestion extends StatefulWidget {
  CreateBookSuggestion({Key? key}) : super(key: key);

  @override
  _CreateBookSuggestionState createState() {
    return _CreateBookSuggestionState();
  }
}

class _CreateBookSuggestionState extends State<CreateBookSuggestion> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  Future<Book>? _futureBook;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xff343434),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.amber[600],
          title: Text(
            'Kaydet',
            style: TextStyle(
              color: Color(0xff343434),
            ),
          ),
        ),
        body: Container(

          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureBook == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 30),
          child: Text(
            'Kitap Kaydı Oluştur',
            style: TextStyle(
              color: Color(0xff343434),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextField(
          controller: _controller1,
          decoration: InputDecoration(hintText: 'Kitap Adı'),
        ),
        TextField(
          controller: _controller2,
          decoration: InputDecoration(hintText: 'Açıklama'),
        ),
        TextField(
          controller: _controller3,
          decoration: InputDecoration(hintText: 'Kitap URL'),
        ),
        TextField(
          controller: _controller4,
          decoration: InputDecoration(hintText: 'Kapak Fotoğrafı URL'),
        ),
        Container(
          color: Colors.amber[600],
          margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
          child: FlatButton(

            onPressed: () {
              setState(() {
                _futureBook = createBook(
                  _controller1.text,
                  _controller2.text,
                  _controller3.text,
                  _controller4.text,
                );
              });
            },
            child: Text('Kaydet', style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),
          ),
        ),
      ],
    );
  }

  FutureBuilder<Book> buildFutureBuilder() {
    return FutureBuilder<Book>(
      future: _futureBook,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.bookTitle);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }
}
