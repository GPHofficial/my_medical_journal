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
import 'login.dart';

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

        primarySwatch: Colors.green,
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
  //final bool isLogged = true;
  final bool isLogged = await _auth.isLogged();
  final MyApp myApp = MyApp(
    //initialRoute: isLogged ? '/menu' : '/login',
    initialRoute: '/menu',
  );
  runApp(myApp);
}