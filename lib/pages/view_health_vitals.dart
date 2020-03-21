import 'package:flutter/material.dart';

import 'view_blood_pressure.dart';

class ViewHealthVitals extends StatefulWidget{
  @override
  State createState() => new ViewHealthVitalsState();
}

class ViewHealthVitalsState extends State<ViewHealthVitals>{
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