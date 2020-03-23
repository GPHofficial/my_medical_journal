// Dart Packages
import 'dart:async';

// Flutter Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

// Flutter Theme
import 'package:flutter/material.dart';

// Firebase Analytics
import 'package:firebase_analytics/firebase_analytics.dart';

//Firebase User
import 'package:firebase_auth/firebase_auth.dart';

//Pages
import 'pages/list_clinic.dart';
import 'pages/list_medication.dart';
import 'pages/list_appointment.dart';
import 'pages/list_health_vitals.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key, this.analytics}) : super(key: key);

  

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
  _MenuPageState createState() => _MenuPageState(this.analytics);
}

class _MenuPageState extends State<MenuPage> {
  _MenuPageState(this.analytics);
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseAnalytics analytics;
  

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
  
 
  // Future<void> syncUserData() async{
  //   final FirebaseUser currentUser = await _auth.currentUser();
  //   dynamic userData = {
  //     "info": {
  //       "email": currentUser.email.length > 0 ? currentUser.email : "",
  //       "name": currentUser.displayName.length > 0 ? currentUser.displayName : "",
  //       "picture": currentUser.photoUrl.length > 0 ? currentUser.photoUrl : "",
  //     }
  //   };
  //   _firestore.collection('users').document(currentUser.uid).setData(userData,merge: true);
  // }
  
  @override
  Widget build(BuildContext context) {

    // syncUserData();
    
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
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new MedicationPage())),
            ),
            RaisedButton(
              child: const Text('Appointment'),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new AppointmentPage())),
            ),
            RaisedButton(
              child: const Text('Clinics'),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new ClinicPage())),
            ),
            RaisedButton(
              child: const Text('Health Vitals'),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new HealthVitalsPage())),
            ),
            RaisedButton(
              child: const Text('Logout'),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context,"/login",arguments:{this.analytics});
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
