import 'package:flutter/material.dart';
import 'package:my_medical_journal/controller/medication_controller.dart';
import '../entities/medication.dart';
import 'list_medication.dart';
import '../medication_manager.dart';

class AddMedication extends StatefulWidget {
  AddMedication({Key key, this.generatedId}) : super(key: key);
  final String generatedId;
  Medication _newMedication = new Medication();
  State createState() => AddMedicationState(this.generatedId);
}

class AddMedicationState extends State<AddMedication> {
  bool mornVal=false;
  bool afternoonVal=false;
  bool nightVal=false;
  AddMedicationState(this.generatedId);
  String generatedId;
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'One';
  var strtoint = {'One':1,'Two':2,'Three':3,'Four':4};
  var textEditingControllers = {
    "name": new TextEditingController(),
    "nickname": new TextEditingController(),
    "dosage": new TextEditingController(),
    "quantity": new TextEditingController(),
    "specialinfo": new TextEditingController(),

  };

  void loadMedicationData(String generatedId) async {
    print(generatedId);
    MedicationController medicationController = new MedicationController();
    Medication retrievedMedication = await medicationController.getMedication(generatedId);
    setState(() {
      widget._newMedication = retrievedMedication;
      textEditingControllers["name"].text = retrievedMedication.medication;
      textEditingControllers["nickname"].text = retrievedMedication.nickname;
      textEditingControllers["dosage"].text = retrievedMedication.dosage == null ? "" : retrievedMedication.dosage.toString();
      textEditingControllers["quantity"].text = retrievedMedication.quantity == null ? "" : retrievedMedication.dosage.toString();
      textEditingControllers["specialinfo"].text = retrievedMedication.quantity == null ? "" : retrievedMedication.dosage.toString();
    });
  }

  void generateTextEditingController(){

  }

  @override
  void initState(){
    super.initState();
    if(generatedId != null){
      loadMedicationData(generatedId);
    }
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text(
          generatedId == null ? "Add Medication" : "Edit Medication",
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
                    controller: textEditingControllers["name"],
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
                    controller: textEditingControllers["nickname"],
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
                    controller: textEditingControllers["dosage"],
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
                    controller: textEditingControllers["quantity"],
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
                  TextFormField(
                    controller: textEditingControllers["specialinfo"],
                    decoration: InputDecoration(
                      labelText: 'Special Info(Optional)',
                    ),
                    validator: (input) {
                      print(input);
                      print(input.runtimeType);
                      print(intParse(input));

                      return null;
                    },
                    onSaved: (input) =>
                        widget._newMedication.setSpecialInfo(input),
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
              Align(
              alignment: FractionalOffset(0, -1),
              child:
                  Text("Check the time of the day you need reminder!",style: TextStyle(),),
              ),
                  Row(
                  children:[Text("Morning:"),
                  Checkbox(
                    value: mornVal,
                    onChanged: (bool value) {
                      setState(() {
                        mornVal = value;
                      });
                    },
                  ),
                  Text("Afternoon:"),
                  Checkbox(
                    value: afternoonVal,
                    onChanged: (bool value) {
                      setState(() {
                        afternoonVal = value;
                      });
                    },
                  ),Text("Night:"),
                  Checkbox(
                    value: nightVal,
                    onChanged: (bool value) {
                      setState(() {
                        nightVal = value;
                      });
                    },
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
                              )
                          ),
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
      //widget._newMedication.setReminders([mornVal,afternoonVal,nightVal]);
      _formKey.currentState.save();
      widget._newMedication.disp();
      MedicationManager manager = new MedicationManager();
       
      MedicationController medicationController = new MedicationController();
      
      // Medication medication = new Medication.set(
      //   widget._newMedication.medication,
      //   widget._newMedication.nickname,
      //   null, // _reminders
      //   widget._newMedication.dosage,
      //   widget._newMedication.frequexncy,
      //   widget._newMedication.quantity,
      //   null, //special Info)
      // );
      if(generatedId == null){
        medicationController.addMedication(widget._newMedication);
      }else{
        widget._newMedication.setId(generatedId);
        medicationController.editMedication(widget._newMedication);
      }
      
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new MedicationPage()));
    }
  }

  String intParse(String s) {
    return s.replaceAll(RegExp(r'[0-9]'), '');
  }
}
