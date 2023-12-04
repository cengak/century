import 'package:flutter/material.dart';
import 'package:century/Pages/Authentication/authentication.dart';
import 'package:century/Pages/Authentication/res/google_sign_in_button.dart';
import 'package:flutter/painting.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.40),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.amber[600],
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(0),
                  bottomRight: const Radius.circular(0),
                ),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(40, 0, 0, 50),
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Color(0xff343434),
                  borderRadius: new BorderRadius.only(
                    bottomLeft: const Radius.circular(180.0),
                    /*bottomRight: const Radius.circular(150.0),*/
                  ),
                ),
                child: Container(
                  child: Image.asset(
                    'assets/C1.png',
                    height: 35,
                  ),
                  margin: EdgeInsets.fromLTRB(50, 0, 0, 50),
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(180.0),
                      bottomRight: const Radius.circular(180.0),
                      topLeft: const Radius.circular(180.0),
                      /*  topRight: const Radius.circular(180.0),*/
                      /*bottomRight: const Radius.circular(150.0),*/
                    ),
                  ),

                  /* BURAYA */
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 100, 20, 50),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.20),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.amber[600],
                  borderRadius: BorderRadius.circular(20)),
              child: FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.amber,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
