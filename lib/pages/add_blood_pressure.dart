import 'package:flutter/material.dart';
import 'package:my_medical_journal/controller/bp_controller.dart';
import '../entities/bloodPressure.dart';
import 'view_blood_pressure.dart';
import 'package:intl/intl.dart';

class AddBloodPressure extends StatefulWidget{
  AddBloodPressure({Key key, this.generatedId}) : super(key: key);
  final String generatedId;
  BloodPressure _newBloodPressure = new BloodPressure();
  State createState() => AddBloodPressureState(this.generatedId);
}

class AddBloodPressureState extends State<AddBloodPressure>{
  String generatedId;
  AddBloodPressureState(this.generatedId);
  final _bpValue = GlobalKey<FormState>();
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
                key: _bpValue,
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
    if(_bpValue.currentState.validate()){
      _bpValue.currentState.save();
      DateTime now = DateTime.now().toLocal();
      String formattedTime = DateFormat('kk:mm').format(now);
      String formattedDate = DateFormat('dd/MM').format(now);
      widget._newBloodPressure.setDate(formattedDate);
      widget._newBloodPressure.setTime(formattedTime);
      BpController bpController = new BpController();
      bpController.addBp(widget._newBloodPressure);
      widget._newBloodPressure.disp();

      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new ViewBloodPressure()));

    }
  }
}