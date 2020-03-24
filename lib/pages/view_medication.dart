import 'package:flutter/material.dart';
import 'package:my_medical_journal/controller/medication_controller.dart';
import 'package:my_medical_journal/entities/medication.dart';
import 'package:my_medical_journal/pages/add_medication.dart';

class ViewMedication extends StatefulWidget{

  ViewMedication({Key key, this.generatedId}) : super(key: key);

  final String generatedId;

  @override
  State createState() => ViewMedicationState(generatedId);
}

class ViewMedicationState extends State<ViewMedication>{

  ViewMedicationState(this.generatedId);

  Medication medication = new Medication.defaults();
  String generatedId;

  void loadMedicationData(String generatedId) async {
    print(generatedId);
    MedicationController medicationController = new MedicationController();
    Medication retrievedMedication = await medicationController.getMedication(generatedId);
    setState(() {
      medication = retrievedMedication;
    });
  }

  @override
  void initState(){
    super.initState();
    loadMedicationData(generatedId);
  }

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
        actions: <Widget>[
          RaisedButton(
                  child: const Text('Edit'),
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new AddMedication(generatedId: medication.getId())
                    ));
                  },
                )
              ,
        ],
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
                medication.medication,
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
                  medication.medication,
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
                  medication.nickname,
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
                  medication.dosage.toString(),
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
                  medication.quantity.toString(),
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
                  medication.frequency.toString(),
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