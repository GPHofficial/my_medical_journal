import 'package:flutter/material.dart';

class ViewMedication extends StatefulWidget{

  @override
  State createState() => ViewMedicationState();
}

class ViewMedicationState extends State<ViewMedication>{

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "View Medication",
          style: new TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'OpenSans'),
        ),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
              new Text(
                "Medication Name:",
                style: new TextStyle(
                    color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
              ),
              new Text(
                "######",
                style: new TextStyle(
                    color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
              ),
            ],
            ),
            new Row(
              children: <Widget>[
                new Text(
                  "Medication Name:",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
                new Text(
                  "######",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(
                  "Medication NickName:",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
                new Text(
                  "######",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(
                  "Medication Dosage:",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
                new Text(
                  "######",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(
                  "Amount Of Medication Available:",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
                new Text(
                  "######",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(
                  "Frequency:",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
                new Text(
                  "######",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}