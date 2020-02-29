// Dart Packages
import 'dart:async';

// Flutter Packages
import 'package:flutter/services.dart';

// Flutter Theme
import 'package:flutter/material.dart';

// Firebase Analytics
import 'package:firebase_analytics/firebase_analytics.dart';

// Firebase Firestore (NoSQL Database)
import 'package:cloud_firestore/cloud_firestore.dart';


class MenuPage extends StatefulWidget {
  MenuPage({Key key, this.analytics}) : super(key: key);

  static Firestore firestore = Firestore();

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
  _MenuPageState createState() => _MenuPageState(this.analytics,firestore);
}

class _MenuPageState extends State<MenuPage> {
  _MenuPageState(this.analytics, this.firestore);
  
  final Firestore _firestore = Firestore.instance;

  final FirebaseAnalytics analytics;
  final Firestore firestore;

  String _counter = "You are not signed in";

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop'),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
  
  void _handleSignIn() async {
    
    //Create
    _firestore.collection('books').document().setData({ 'title': 'title', 'author': 'author' });
    //Search
    _firestore.collection('books').where("title", isEqualTo: "title").snapshots().listen((data) => data.documents.forEach((doc) => print(doc["author"])));
    //Get
    _firestore.collection('books').document('CqHHoQpZ0rCv9EUDCz7j').get().then((DocumentSnapshot ds) {
      // use ds as a snapshot
      ds.data.forEach((id,doc) => print(id + " " + doc["author"]));
    });
    //List
    //Update
    //Delete


    setState(() {
      // _counter = "Signed in as " + user.displayName;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MenuPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.display1,
            // ),
            // MaterialButton(
            //   child: const Text('Sign In with Google'),
            //   onPressed: _handleSignIn,
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
