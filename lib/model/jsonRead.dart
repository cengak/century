import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<SuggestionBook> readBookJson() async {
  final response =
  await http.get(Uri.parse('https://firebasestorage.googleapis.com/v0/b/century-de709.appspot.com/o/books.json?alt=media&token=d590725e-fc5f-40fd-b647-3d93b7702cd7'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return SuggestionBook.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<http.Response> fetchPhotos(http.Client client) async {
  return client.get(Uri.parse('https://firebasestorage.googleapis.com/v0/b/century-de709.appspot.com/o/books.json?alt=media&token=d590725e-fc5f-40fd-b647-3d93b7702cd7'));
}

class SuggestionBook {
  final String bookTitle;
  final String bookDetail;
  final String bookURL;
  final String imgURL;

  SuggestionBook({
    required this.bookTitle,
    required this.bookDetail,
    required this.bookURL,
    required this.imgURL,
  });

  factory SuggestionBook.fromJson(Map<String, dynamic> json) {
    return SuggestionBook(
      bookTitle: json['bookTitle'],
      bookDetail: json['bookDetail'],
      bookURL: json['bookURL'],
      imgURL: json['imgURL'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final  Future<SuggestionBook> futureAlbum = readBookJson();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example1'),
        ),
        body: Center(
          child: FutureBuilder<SuggestionBook>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('${snapshot.data!.bookTitle} ${snapshot.data!.bookDetail} ${snapshot.data!.bookURL} ${snapshot.data!.imgURL}');
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}