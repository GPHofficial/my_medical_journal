// Dart Packages
import 'dart:async';
import 'dart:io';

// Flutter Theme
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

// Firebase Analytics
import 'package:firebase_analytics/firebase_analytics.dart';

// Firebase Auth
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.analytics}) : super(key: key);

  final String title = "My Medical Journal";
  final FirebaseAnalytics analytics;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _LoginPageState createState() => _LoginPageState(this.analytics);
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState(this.analytics);

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseAnalytics analytics;

  bool success = false;
  String name = "";

  void _handleGuestSignInBtn() async {
    await analytics.logLogin(loginMethod: "LoginAttempt-Guest");
    _signInAnonymously().then((FirebaseUser user) {
      analytics.logLogin(loginMethod: "LoginSuccess-Guest");
      setState(() {
        success = true;
      });
    }).catchError((e) {
      analytics.logLogin(loginMethod: "LoginFailure-Guest");
      setState(() {
        success = false;
      });
    });
  }

  Future<FirebaseUser> _signInAnonymously() async {
    final FirebaseUser user = (await _auth.signInAnonymously()).user;
    assert(user != null);
    assert(user.isAnonymous);
    assert(!user.isEmailVerified);
    assert(await user.getIdToken() != null);
    if (Platform.isIOS) {
      // Anonymous auth doesn't show up as a provider on iOS
      assert(user.providerData.isEmpty);
    } else if (Platform.isAndroid) {
      // Anonymous auth does show up as a provider on Android
      assert(user.providerData.length == 1);
      assert(user.providerData[0].providerId == 'firebase');
      assert(user.providerData[0].uid != null);
      assert(user.providerData[0].displayName == null);
      assert(user.providerData[0].photoUrl == null);
      assert(user.providerData[0].email == null);
    }

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    return user;
  }

  Future<FirebaseUser> _handleGoogleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return user;
  }

  Future<bool> _handleGoogleSignInBtn() async {
    analytics.logLogin(loginMethod: "LoginAttempt-Google");
    FirebaseUser user = await _handleGoogleSignIn().catchError((e) {
      analytics.logLogin(loginMethod: "LoginFailure-Google");
      return false;
    });

    analytics.setUserId(user.uid);
    analytics.logLogin(loginMethod: "LoginSuccess-Google");
    setState(() {
      name = user.displayName;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontFamily: "OpenSans"),
        ),
      ),
      body: Builder(
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(image: AssetImage('assets/images/logo2.jpg')),
            Text(
              "Welcome to My Medical Journal,\n A One Stop App for all your medical needs!",
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
            ),
            Container(
              height: 200,
            ),
            GoogleSignInButton(onPressed: () async {
              bool success = await _handleGoogleSignInBtn();
              if (success == null) return;
              if (success == true) {
                print("LOGIN SUCCESS!");
                Fluttertoast.showToast(
                    msg: "Welcome, " + name,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pushReplacementNamed(context, "/menu",
                    arguments: {this.analytics});
              }
              if (success == false) {
                Fluttertoast.showToast(
                    msg: "Login Failed, Try again!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                print("LOGIN FAIL!");
                return;
              }
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/thumb.png'),
                  width: 200,
                ),
              ],
            )

            // RaisedButton(
            //   child: const Text('Use as Guest'),
            //   onPressed: () {
            //     _handleGuestSignInBtn();
            //     if(success == null) return;
            //     SnackBar snackBar = SnackBar(content: Text( success ?
            //       'Successfully signed in as Guest.':
            //       'Sign in failed')
            //     );
            //     Scaffold.of(context).showSnackBar(snackBar);
            //     if(success == false) return;
            //     Navigator.pushReplacementNamed(context,"/menu",arguments:{this.analytics});
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
