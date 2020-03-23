import 'package:flutter/material.dart';
import '../entities/medication.dart';
import 'list_medication.dart';
import '../medication_manager.dart';

class AddMedication extends StatefulWidget {
  final _newMedication = new Medication();
  @override
  State createState() => AddMedicationState();
}

class AddMedicationState extends State<AddMedication> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'One';
  var strtoint = {'One':1,'Two':2,'Three':3,'Four':4};


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
                    onSaved:
                        (input) =>
                        widget._newMedication.setName(input),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Medication NickName',
                    ),
                    validator: (input) {
                      if (input.isEmpty) return "Enter Nickname";
                      return null;
                    },
                    onSaved: (input){
                        widget._newMedication.setNickname(input);
                    },
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
                    onSaved: (input) =>
                        widget._newMedication.setDosage(int.parse(input)),
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
                    onSaved: (input) =>
                        widget._newMedication.setQuantity(int.parse(input)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Enter Frequency of Medication(Daily):               ",style:TextStyle(color:Colors.black54,fontSize: 16)),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black54),
                        underline: Container(
                          height: 2,
                          color: Colors.green,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                           widget._newMedication.setFrequency(strtoint[dropdownValue]);

                          });
                        },
                        items: <String>['One', 'Two', 'Three', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
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
      widget._newMedication.disp();
      MedicationManager manager = new MedicationManager();
       manager.addMedication(widget._newMedication.medication, widget._newMedication.nickname, widget._newMedication.dosage, widget._newMedication.frequency, widget._newMedication.quantity);
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new MedicationPage()));
    }
  }

  String intParse(String s) {
    return s.replaceAll(RegExp(r'[0-9]'), '');
  }
}
