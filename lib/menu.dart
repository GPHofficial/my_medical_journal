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
import 'package:my_medical_journal/controller/user_controller.dart';
import 'package:my_medical_journal/entities/user.dart';

//Pages
import 'pages/list_clinic.dart';
import 'pages/list_medication.dart';
import 'pages/list_appointment.dart';
import 'pages/list_health_vitals.dart';
import 'adapters/option_model.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future onSelectNotification(String payload) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("ALERT"),
          content: Text("CONTENT: $payload"),
        ));
  }

  // showNotification() async {
  //   var time = Time(17, 59 , 0);
  //   var androidPlatformChannelSpecifics =
  //   AndroidNotificationDetails('repeatDailyAtTime channel id',
  //       'repeatDailyAtTime channel name', 'repeatDailyAtTime description');
  //   var iOSPlatformChannelSpecifics =
  //   IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    // await flutterLocalNotificationsPlugin.showDailyAtTime(
    //     0,
    //     "wassup",
    //     'Daily notification shown at approximately ${time.hour}:${time
    //         .minute}:${time.second}',
    //     time,
    //     platformChannelSpecifics);
    // print("DONE");


  // }


  ////////
  _MenuPageState(this.analytics);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAnalytics analytics;

  int _firebaseCheckStatus = 0;


  Future<void> syncUserData() async {
    // final FirebaseUser currentUser = await _auth.currentUser();
    // UserController uc = new UserController();
    // uc.addOrUpdateUser(currentUser.uid, currentUser.displayName,
    //     currentUser.email, currentUser.photoUrl);
  }

  @override
  initState() {
    super.initState();
    syncUserData();
    // flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iOS = IOSInitializationSettings();
    // var initSettings = InitializationSettings(android, iOS);
    // flutterLocalNotificationsPlugin.initialize(initSettings,
    //     onSelectNotification: onSelectNotification);
  }

  int _selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Text(
          'My Medical Journal',
          style: new TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'OpenSans'),
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            child: Text(
              'LOGOUT',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login",
                  arguments: {this.analytics});
            },
          )
        ],
      ),
      body:
          Column(
          children: <Widget>[
            Image(image: AssetImage('assets/images/logo.jpg')),
            new Expanded(
            child: ListView.builder(
            itemCount: options.length + 2,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return SizedBox(height: 15.0);
              } else if (index == options.length + 1) {
                return SizedBox(height: 100.0);
              }
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10.0),
                width: double.infinity,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: _selectedOption == index - 1
                      ? Border.all(color: Colors.black26)
                      : null,
                ),
                child: ListTile(
                  leading: options[index - 1].icon,
                  title: Text(
                    options[index - 1].title,
                    style: TextStyle(
                      color: _selectedOption == index - 1
                          ? Colors.black
                          : Colors.grey[600],
                    ),
                  ),
                  subtitle: Text(
                    options[index - 1].subtitle,
                    style: TextStyle(
                      color: _selectedOption == index - 1
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                  selected: _selectedOption == index - 1,
                  onTap: () {
                    setState(() {
                      _selectedOption = index - 1;
                      if (_selectedOption == 0) {


                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new MedicationPage()));
                      }
                      if (_selectedOption == 1) {

                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new AppointmentPage()));
                        // showNotification();
                      }
                      if (_selectedOption == 2) {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new ClinicPage()));
                      }
                      if (_selectedOption == 3) {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new HealthVitalsPage()));
                      }
                    });
                  },
                ),
              );
            },
          ),
            ),
      ],
          ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//
//
//
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return Scaffold(
//      appBar: AppBar(
//        automaticallyImplyLeading: false,
//        // Here we take the value from the MenuPage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
//      body: Builder(
//        builder: (context) =>
//          GridView.count(
//          // Create a grid with 2 columns. If you change the scrollDirection to
//          // horizontal, this produces 2 rows.
//          crossAxisCount: 2,
//          // Generate 100 widgets that display their index in the List.
//          children: <Widget>[
//            RaisedButton(
//              child: const Text('Medication'),
//              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new MedicationPage())),
//            ),
//            RaisedButton(
//              child: const Text('Appointment'),
//              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new AppointmentPage())),
//            ),
//            RaisedButton(
//              child: const Text('Clinics'),
//              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new ClinicPage())),
//            ),
//            RaisedButton(
//              child: const Text('Health Vitals'),
//              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new HealthVitalsPage())),
//            ),
//            RaisedButton(
//              child: const Text('Logout'),
//              onPressed: () {
//                FirebaseAuth.instance.signOut();
//                Navigator.pushNamed(context,"/login",arguments:{this.analytics});
//              },
//            ),
//          ]
//        )
//      // floatingActionButton: FloatingActionButton(
//      //   onPressed: _incrementCounter,
//      //   tooltip: 'Increment',
//      //   child: Icon(Icons.add),
//      // ), // This trailing comma makes auto-formatting nicer for build methods.
//    ));
//
//  }
}
