import 'package:flutter/material.dart';
import 'package:my_medical_journal/controller/bg_controller.dart';
import 'package:my_medical_journal/entities/bloodGlucose.dart';
import 'package:intl/intl.dart';
import 'package:my_medical_journal/pages/view_blood_glucose.dart';

class AddBloodGlucose extends StatefulWidget{
  AddBloodGlucose({Key key, this.generatedId}) : super(key: key);
  final String generatedId;
  BloodGlucose _newBloodGlucose = new BloodGlucose();
  State createState() => AddBloodGlucoseState(this.generatedId);
}

class AddBloodGlucoseState extends State<AddBloodGlucose>{
  String generatedId;
  AddBloodGlucoseState(this.generatedId);
  final _bgValue = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
        return new Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green,
            flexibleSpace: new Container(
              alignment: Alignment.center,
            ),
            title: new Row(
              children: <Widget>[
                new IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new ViewBloodGlucose())),
                ),
                new Text(
                  "Add Blood Glucose",
                  style: new TextStyle(
                      color: Colors.white, fontSize: 30, fontFamily: 'OpenSans'),
                ),
              ],
            ),
          ),
          body: new Card(
            child: Padding(
              padding: new EdgeInsets.all(8.0),
              child: Form(
                key: _bgValue,
                child: SingleChildScrollView(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField( // enter glucose
                        decoration: InputDecoration(
                          labelText: 'Blood Glucose'
                          ),
                          validator: (input){
                            if (input.isEmpty) return "Enter Blood Glucose Value";
                            return null;
                          },
                          onSaved: 
                            (input) => widget._newBloodGlucose.setGlucose(input),
                      ),
                      TextFormField( // enter date
                        decoration: InputDecoration(
                          labelText: 'Date'
                          ),
                          validator: (input){
                            if (input.isEmpty) return "Enter Date";
                            return null;
                          },
                          onSaved: 
                            (input) => widget._newBloodGlucose.setDate(input),
                      ),
                      TextFormField( // enter time
                        decoration: InputDecoration(
                          labelText: 'Time'
                          ),
                          validator: (input){
                            if (input.isEmpty) return "Enter Time";
                            return null;
                          },
                          onSaved: 
                            (input) => widget._newBloodGlucose.setTime(input),
                      ),
                        Row( // Save button
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: new EdgeInsets.all(0.0),
                        child: RaisedButton(
                          color: Colors.green,
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
    if(_bgValue.currentState.validate()){
      _bgValue.currentState.save();
      //DateTime now = DateTime.now().toLocal();
      //DateTime epoch = DateTime.fromMillisecondsSinceEpoch(1585288500000);
      //String formattedTime = DateFormat('kk:mm').format(now);
     // String formattedDate = DateFormat('dd/MM').format(now);
      //widget._newBloodGlucose.setDate(formattedDate);
      //widget._newBloodGlucose.setTime(formattedTime);
      BgController bgController = new BgController();
      bgController.addBg(widget._newBloodGlucose);


      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ViewBloodGlucose()));

    }
  }
}