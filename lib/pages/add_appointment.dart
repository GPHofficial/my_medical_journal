import 'package:flutter/material.dart';
import 'package:my_medical_journal/controller/appointment_controller.dart';
import '../entities/appointment.dart';
import 'list_appointment.dart';
import '../appointment_manager.dart';

class AddAppointment extends StatefulWidget {
  AddAppointment({Key key, this.generatedId}) : super(key: key);
  final String generatedId;
  Appointment _newAppointment = new Appointment();
  State createState() => AddAppointmentState(this.generatedId);
}

class AddAppointmentState extends State<AddAppointment> {
  AddAppointmentState(this.generatedId);
  String generatedId;
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'One';
  var strtoint = {'One':1,'Two':2,'Three':3,'Four':4};
  var textEditingControllers = {
    "Date": new TextEditingController(),
    "Time": new TextEditingController(),
    "ClinicName": new TextEditingController(),
    "AppointmentName": new TextEditingController(),
    "Documents": new TextEditingController(),
  };

  void loadAppointmentData(String generatedId) async {
    print(generatedId);
    AppointmentController appointmentController = new AppointmentController();
    Appointment retrievedAppointment = await appointmentController.getAppointment(generatedId);
    setState(() {
      widget._newAppointment = retrievedAppointment;
      textEditingControllers["Date"].text = retrievedAppointment.date;
      textEditingControllers["Time"].text = retrievedAppointment.time;
      textEditingControllers["ClinicName"].text = retrievedAppointment.clinicName ;
      textEditingControllers["AppointmentName"].text = retrievedAppointment.appointName ;
      textEditingControllers["Documents"].text = retrievedAppointment.documents ;
    });
  }

  void generateTextEditingController(){

  }

  @override
  void initState(){
    super.initState();
    if(generatedId != null){
      loadAppointmentData(generatedId);
    }
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text(
          generatedId == null ? "Add Appointment" : "Edit Appointment",
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
                    controller: textEditingControllers["Date"],
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
                    controller: textEditingControllers["Time"],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Enter Clinic Name):  ", style:TextStyle(color:Colors.black54,fontSize: 16)),
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
                            widget._newAppointment.setClinicName(dropdownValue);

                          });
                        },
                        items: <String>['Tan Family Clinic', 'Fullerton Health', 'Sim Family Clinic', 'Tay Family Clinic']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: textEditingControllers["AppointmentName"],
                    decoration: InputDecoration(
                      labelText: 'Appointment Name',
                    ),
                    validator: (input) {
                      if (input.isEmpty) return "Enter Appointment Name";
                      return null;
                    },
                    onSaved: (input){
                      widget._newAppointment.setClinicName(input);
                    },
                  ),
                  TextFormField(
                    controller: textEditingControllers["Documents"],
                    decoration: InputDecoration(
                      labelText: 'Documents to bring',
                    ),
                    validator: (input) {
                      if (input.isEmpty) return "Enter Documents Name";
                      return null;
                    },
                    onSaved: (input){
                      widget._newAppointment.setDocuments(input);
                    },
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
      AppointmentManager manager = new AppointmentManager();

      AppointmentController appointmentController = new AppointmentController();

      // Appointment Appointment = new Appointment.set(
      //   widget._newAppointment.Appointment,
      //   widget._newAppointment.nickname,
      //   null, // _reminders
      //   widget._newAppointment.dosage,
      //   widget._newAppointment.frequency,
      //   widget._newAppointment.quantity,
      //   null, //special Info)
      // );
      if(generatedId == null){
        appointmentController.addAppointment(widget._newAppointment);
      }else{
        widget._newAppointment.setId(generatedId);
        appointmentController.editAppointment(widget._newAppointment);
      }

      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new appointmentPage()));
    }
  }

  String intParse(String s) {
    return s.replaceAll(RegExp(r'[0-9]'), '');
  }
}
