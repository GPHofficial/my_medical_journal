import 'package:flutter/material.dart';
import 'package:my_medical_journal/pages/view_blood_glucose.dart';
import 'view_blood_pressure.dart';
import '../menu.dart';

class HealthVitalsPage extends StatefulWidget{
  @override
  State createState() => new HealthVitalsPageState();
}

class HealthVitalsPageState extends State<HealthVitalsPage>{

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: new Row(
          children: <Widget>[
            new IconButton(
              icon: Icon(Icons.home),
              onPressed:
                  () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new MenuPage())),

            ),
            new Text(
              "Health Vitals",
              style: new TextStyle(
                  color: Colors.white, fontSize: 30, fontFamily: 'OpenSans'),
            ),
          ],
        ),
        ),
        body: Builder(
          builder: (context) => 
          GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            RaisedButton(
              child: const Text('Blood Pressure'),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new ViewBloodPressure())),
              ),
            RaisedButton(
              child: const Text('Blood Glucose'),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new ViewBloodGlucose())),
              ),
          ]
          ),
          )
      );
  }
}
