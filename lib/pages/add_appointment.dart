import 'package:flutter/material.dart';
import '../entities/appointment.dart';
import 'list_appointment.dart';

class AddAppointment extends StatefulWidget {
  final _newAppointment = new Appointment();
  @override
  State createState() => AddAppointmentState();
}

class AddAppointmentState extends State<AddAppointment> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'One';
  var strings = {'One':1,'Two':2,'Three':3,'Four':4};

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Add Appointment",
          style: new TextStyle(
              color: Colors.white, fontSize: 25, fontFamily: 'OpenSans'),
        ),
      ),
      body: new Card(
        child: Padding(
          padding: new EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Appointment Date',
                    ),
                    validator: (input) {
                      if (input.isEmpty) return "Enter Date";
                      return null;
                    },
                    onSaved:
                        (input) =>
                        widget._newAppointment.setDate(input),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Appointment Time',
                    ),
                    validator: (input) {
                      if (input.isEmpty) return "Enter Time";
                      return null;
                    },
                    onSaved: (input){
                        widget._newAppointment.setTime(input);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Clinic Name',
                    ),
                    validator: (input) {
                    if (input.isEmpty) return "Enter Clinic Name";
                    return null;
                    },
                    onSaved: (input) =>
                        widget._newAppointment.setclinicName(input),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Appointment Name',
                    ),
                    validator: (input) {
                    if (input.isEmpty) return "Enter Appointment Name";
                    return null;
                    },
                    onSaved: (input) =>
                        widget._newAppointment.setAppointmentName(input),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Documents',
                    ),
                    validator: (input) {
                    if (input.isEmpty) return "Enter Documents";
                    return null;
                    },
                    onSaved: (input) =>
                        widget._newAppointment.setDocuments(input),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: new EdgeInsets.all(0.0),
                        child: RaisedButton(
                          color: Colors.green,
                          elevation: 2,
                          onPressed: _submit,
                          child: Text("Save",
                              style: TextStyle(
                                color: Colors.white,
                              )),
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

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget._newAppointment.disp();
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new AppointmentPage()));
    }
  }

  String intParse(String s) {
    return s.replaceAll(RegExp(r'[0-9]'), '');
  }
}
