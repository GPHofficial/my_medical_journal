import 'package:flutter/material.dart';
import '../entities/medication.dart';
import 'medication_tracker.dart';

class AddMedication extends StatefulWidget {
  @override
  State createState() => AddMedicationState();
}

class AddMedicationState extends State<AddMedication> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _nickname;
  int _dosage;
  int _quantity;
  String _freq;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Add Medication",
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
                      labelText: 'Medication Name',
                    ),
                    validator: (input) {
                      if (input.isEmpty) return "Enter Name";
                      return null;
                    },
                    onSaved: (input) => _name = input,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Medication NickName',
                    ),
                    validator: (input) {
                      if (input.isEmpty) return "Enter Nickname";
                      return null;
                    },
                    onSaved: (input) => _nickname = input,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Medication Dosage',
                    ),
                    validator: (input) {
                      print(input);
                      print(input.runtimeType);
                      print(intParse(input));
                      if (intParse(input) != '' || input.isEmpty)
                        return "Enter Dosage(Only Numeric)";
                      return null;
                    },
                    onSaved: (input) => _dosage = int.parse(input),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Amount of Medication Available',
                    ),
                    validator: (input) {
                      print(input);
                      print(input.runtimeType);
                      print(intParse(input));
                      if ((intParse(input) != '') || input.isEmpty)
                        return "Enter Amount Bought(Only Numeric)";
                      return null;
                    },
                    onSaved: (input) => _quantity = int.parse(input),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      DropdownButton<String>(
                        hint:Text("Number Of Times Per Day"),
                        items: <String>['1', '2', '3', '4'].map((String value) {
                          return new DropdownMenuItem<String>(

                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged:(value) => _freq = value,
                      ),

                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: new EdgeInsets.all(8.0),
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
      print(_name);
      print(_nickname);
      print(_dosage);
      print(_quantity);
      print(_freq);
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new MedicationTracker()));
    }
  }

  String intParse(String s) {
    return s.replaceAll(RegExp(r'[0-9]'), '');
  }
}
