import 'package:flutter/material.dart';
import 'package:my_medical_journal/controller/medication_controller.dart';
import 'package:my_medical_journal/entities/medication.dart';
import 'package:my_medical_journal/pages/add_medication.dart';
import 'list_medication.dart';

class ViewMedication extends StatefulWidget{

  ViewMedication({Key key, this.generatedId}) : super(key: key);

  final String generatedId;

  @override
  State createState() => ViewMedicationState(generatedId);
}

class ViewMedicationState extends State<ViewMedication>{

  ViewMedicationState(this.generatedId);
  MedicationController medicationController;

  Medication medication = new Medication.defaults();
  String generatedId;

  void loadMedicationData(String generatedId) async {
    print(generatedId);
    medicationController = new MedicationController();
    Medication retrievedMedication = await medicationController.getMedication(generatedId);
    setState(() {
      medication = retrievedMedication;
    });


  }
//ADD CODE FOR DELETE
  void deleteMedication(String generatedId) async{
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new MedicationPage()));
    medicationController.deleteMedication(generatedId);
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
          FlatButton(
                  textColor: Colors.white,
                  child: const Text('Edit',style: TextStyle(fontSize: 16.0),),
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
                  "Medication Nickname:",
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
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  iconSize: 50,
                  icon: Icon(Icons.delete_forever),
                  color: Colors.red,
                  onPressed: () {
                      deleteMedication(generatedId);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}