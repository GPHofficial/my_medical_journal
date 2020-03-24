import 'package:flutter/material.dart';
import 'package:my_medical_journal/controller/vitals_controller.dart';
import '../entities/bloodPressure.dart';
import 'view_blood_pressure.dart';
import 'package:intl/intl.dart';

class AddBloodPressure extends StatefulWidget{
  final _newBloodPressure = new BloodPressure();
  @override
  State createState() => AddBloodPressureState();
}

class AddBloodPressureState extends State<AddBloodPressure>{
  final _BPValue = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){


        return new Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: new AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              "Add Blood Pressure",
              style: new TextStyle(
                  color: Colors.white, fontSize: 25, fontFamily: 'OpenSans'),
            ),
          ),
          body: new Card(
            child: Padding(
              padding: new EdgeInsets.all(8.0),
              child: Form(
                key: _BPValue,
                child: SingleChildScrollView(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField( // enter diastolic
                        decoration: InputDecoration(
                          labelText: 'Diastolic'
                          ),
                          validator: (input){
                            if (input.isEmpty) return "Enter Diastolic Value";
                            return null;
                          },
                          onSaved: 
                            (input) => widget._newBloodPressure.setDiastolic(input),
                      ),
                      TextFormField( // enter systolic 
                        decoration: InputDecoration(
                          labelText: 'Systolic'
                          ),
                          validator: (input){
                            if(input.isEmpty) return "Enter Systolic Value";
                            return null;
                          },
                          onSaved: 
                            (input) => widget._newBloodPressure.setSystolic(input),
                      ),
                      TextFormField( // enter heart rate
                        decoration: InputDecoration(
                          labelText: 'Heart Rate'
                          ),
                          validator: (input){
                            if(input.isEmpty) return "Enter Heart Rate";
                            return null;
                          },
                          onSaved:
                            (input) => widget._newBloodPressure.setHeartrate(input),    
                        ),
                        Row( // Save button
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: new EdgeInsets.all(0.0),
                        child: RaisedButton(
                          color: Colors.blue,
                          elevation: 2,
                          onPressed: _submit,
                          child: Text("Save", style: TextStyle( color: Colors.white,)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

  void _submit(){
    if(_BPValue.currentState.validate()){
      _BPValue.currentState.save();
      DateTime now = DateTime.now();
      String formattedTime = DateFormat('kk:mm:ss').format(now);
      String formattedDate = DateFormat('dd/MM').format(now);
      widget._newBloodPressure.setDate(formattedDate);
      widget._newBloodPressure.setTime(formattedTime);
      //BpController addbp = new BpController();
      //addbp.addbp(uid, widget._newBloodPressure.diastolic, widget._newBloodPressure.systolic, widget._newBloodPressure.heartRate, widget._newBloodPressure.date, widget._newBloodPressure.time);
      widget._newBloodPressure.disp();

      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new ViewBloodPressure()));

    }
  }
}