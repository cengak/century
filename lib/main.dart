import 'package:century/Pages/Entry.dart';
import 'package:century/Pages/Authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:century/Pages/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /** Initializing FlutterFire# **/
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
              child: Text(
            'Beklenilmeyen bir hata oluştu!..',
            textDirection: TextDirection.ltr,
          ));
        }

        // Once complete, show your application
        else if (snapshot.connectionState == ConnectionState.done) {
          return LoginPage();
          //return Center(child:Text('Bağlandı!..', textDirection: TextDirection.ltr,));
        }

        // Otherwise, show something whilst waiting for initialization to complete
        else {
          return Center(
              child: Text(
            'Yükleniyor....',
            textDirection: TextDirection.ltr,
          ));
        }
      },
    );
  }
}
