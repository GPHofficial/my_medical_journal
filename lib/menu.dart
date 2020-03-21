// Dart Packages
import 'dart:async';

// Flutter Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

// Flutter Theme
import 'package:flutter/material.dart';

// Firebase Analytics
import 'package:firebase_analytics/firebase_analytics.dart';

// Firebase Firestore (NoSQL Database)
import 'package:cloud_firestore/cloud_firestore.dart';

//Firebase User
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/medication_tracker.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseAnalytics analytics;
  final Firestore firestore;

  int _firebaseCheckStatus = 0;

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
  
  Future<void> _firestoreCheck() async {
    


    // For reference: 
    // https://pub.dev/packages/cloud_firestore#-example-tab-
    // https://pub.dev/documentation/cloud_firestore/latest/cloud_firestore/cloud_firestore-library.html

    //Create
    DocumentReference generatedDocRef = await _firestore.collection('books').add({ 'title': 'title', 'author': 'author' }).catchError((e) => 
      setState(() {
        _firebaseCheckStatus = -1;
      })
    );


    String generatedId = generatedDocRef.documentID;
    print("Created DocumentId: " + generatedId);

    //Search
    QuerySnapshot results = await _firestore.collection('books').where("title", isEqualTo: "title").getDocuments().catchError((e) => 
      setState(() {
        _firebaseCheckStatus = -1;
      })
    );

    List<DocumentSnapshot> docList = results.documents.toList();
    DocumentSnapshot value = docList.firstWhere(
      (doc){
        return doc.documentID == generatedId;
      }, 
      orElse: () => null
    );


    if(value==null){
      setState(() {
        _firebaseCheckStatus = -1;
      });
    }



    //Listen (Runs whenever there's changes to documents)
    // _firestore.collection('books').where("title", isEqualTo: "title").snapshots().listen((data) => 
    //     data.documents.forEach((doc) => {
    //       if(doc.documentID == generatedId){
    //         print("Listen DocumentId found: " + generatedId)
    //       }
    //     })
    //   );

    //Get
    await _firestore.collection('books').document(generatedId).get().then((DocumentSnapshot ds) {
      if(ds.documentID == generatedId && ds.data != null){
        print("Get DocumentId found: " + generatedId);
      }else{
        setState(() {
          _firebaseCheckStatus = -1;
        });
      }
    }).catchError((e) => 
      setState(() {
        _firebaseCheckStatus = -1;
      })
    );

    
    
    // //Update
    await _firestore.collection('books').document(generatedId).updateData({'author': 'not author'});
    //Update Check
    await _firestore.collection('books').document(generatedId).get().then((DocumentSnapshot ds) {
      if(ds.documentID == generatedId){
        if(ds.data['author'] == "not author"){
          print("Updated DocumentId found: " + generatedId);
        }else{
          setState(() {
          _firebaseCheckStatus = -1;
          });
        }
      }
    }).catchError((e) => 
      setState(() {
        _firebaseCheckStatus = -1;
      })
    );

    // //Delete
    await _firestore.collection('books').document(generatedId).delete();
    //Delete Check
    await _firestore.collection('books').document(generatedId).get().then((DocumentSnapshot ds) {
      if(ds.data != null){
        setState(() {
          _firebaseCheckStatus = -1;
        });
      }else{
        print("Deleted DocumentId: " + generatedId);
      }
    });

    if(_firebaseCheckStatus == 0)
      setState(() {
          _firebaseCheckStatus = 1;
      });
    
  }

  Future<void> syncUserData() async{
    final FirebaseUser currentUser = await _auth.currentUser();
    dynamic userData = {
      "info": {
        "email": currentUser.email.length > 0 ? currentUser.email : "",
        "name": currentUser.displayName.length > 0 ? currentUser.displayName : "",
        "picture": currentUser.photoUrl.length > 0 ? currentUser.photoUrl : "",
      }
    };
    _firestore.collection('users').document(currentUser.uid).setData(userData,merge: true);
  }
  @override
  Widget build(BuildContext context) {

    syncUserData();
    
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
      body: Builder(
        builder: (context) => 
          GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: <Widget>[
            RaisedButton(
              child: const Text('Medication'),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new MedicationTracker())),
            ),
            RaisedButton(
              child: const Text('Appointment'),
              onPressed: () {Navigator.pushNamed(context,"/menu",arguments:{this.analytics});},
            ),
            RaisedButton(
              child: const Text('Clinics'),
              onPressed: () {Navigator.pushNamed(context,"/menu",arguments:{this.analytics});},
            ),
            RaisedButton(
              child: const Text('Health Vitals'),
              onPressed: () {Navigator.pushNamed(context,"/menu",arguments:{this.analytics});},
            ),
            RaisedButton(
              child: const Text('Logout'),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context,"/login",arguments:{this.analytics});
              },
            ),RaisedButton(
              child: const Text('Check Firestore'),
              onPressed: () async {
                await _firestoreCheck();
                if(_firebaseCheckStatus != null){
                  SnackBar snackBar = SnackBar(content: Text( _firebaseCheckStatus == 1 ? 
                    'Firestore Check Pass': 
                    'Firestore Check Failed')
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ]
        )
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    ));
    
  }
}
