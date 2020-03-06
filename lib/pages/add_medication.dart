import 'package:flutter/material.dart';
import '../entities/medication.dart';

class AddMedication extends StatefulWidget {

  @override
  State createState() => AddMedicationState();
}

class AddMedicationState extends State<AddMedication> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _nickname;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Add Medication",
          style : new TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'OpenSans'
          ),
        ),
      ),
      body: new Card(
        child: Padding(
          padding: new EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText : 'Medication Name',
                  ),
                  validator: (input){
                    if(input.isEmpty)
                      return "Enter Name";
                    return null;
                  },
                  onSaved: (input) => _name = input,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText : 'Medication NickName',
                  ),
                  validator: (input){
                    if(input.isEmpty)
                      return "Enter Name";
                    return null;
                  },
                  onSaved: (input) => _nickname = input,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: new EdgeInsets.all(8.0),
                      child: RaisedButton(
                          color: Colors.green,

                          onPressed: null,
                          child: Text("Add"),

                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
