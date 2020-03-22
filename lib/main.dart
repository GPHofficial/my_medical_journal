// Dart Packages
import 'dart:async';

// Flutter Theme
import 'package:flutter/material.dart';

// Firebase Analytics
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

// Localization
import 'package:flutter_localizations/flutter_localizations.dart';

// Firebase Auth
import 'package:firebase_auth/firebase_auth.dart';

//Pages
import 'menu.dart';
import 'account/login.dart';
import 'pages/medication_tracker.dart';
import 'pages/add_medication.dart';
import 'pages/view_medication.dart';
import 'pages/add_appointment.dart';
import 'pages/appointmentpage.dart';

class MyApp extends StatelessWidget {

  final String initialRoute;

  MyApp({this.initialRoute});

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Medical Journal',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),

      initialRoute: initialRoute,
      routes: {
        '/login': (context) => LoginPage(analytics: analytics,),
        '/menu': (context) => MenuPage(analytics: analytics,),
      },


      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        // const Locale.fromSubtags(languageCode: 'zh'), // Chinese *See Advanced Locales below*
        // ... other locales the app supports
      ],
    );
  }
}

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> isLogged() async {
    try {
      final FirebaseUser user = await _firebaseAuth.currentUser();
      return user != null;
    } catch (e) {
      return false;
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Auth _auth = Auth();
  final bool isLogged = await _auth.isLogged();
  final MyApp myApp = MyApp(
    initialRoute: isLogged ? '/login' : '/menu',
  );
  runApp(myApp);
}