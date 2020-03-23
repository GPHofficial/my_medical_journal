import 'package:flutter/material.dart';

import 'view_blood_pressure.dart';

class HealthVitalsPage extends StatefulWidget{
  @override
  State createState() => new HealthVitalsPageState();
}

class HealthVitalsPageState extends State<HealthVitalsPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Vitals'),
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
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new ViewBloodPressure())),
              ),
          ]
          ),
          )
      );
  }
}