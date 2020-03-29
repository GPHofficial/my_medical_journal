import 'package:flutter/material.dart';
import 'package:my_medical_journal/controller/appointment_controller.dart';
import 'package:my_medical_journal/entities/appointment.dart';
import 'package:my_medical_journal/pages/add_appointment.dart';

class ViewAppointment extends StatefulWidget{

  ViewAppointment({Key key, this.generatedId}) : super(key: key);

  final String generatedId;

  @override
  State createState() => ViewAppointmentState(generatedId);
}

class ViewAppointmentState extends State<ViewAppointment>{

  ViewAppointmentState(this.generatedId);

  Appointment appointment = new Appointment.defaults();
  String generatedId;

  void loadAppointmentData(String generatedId) async {
    print(generatedId);
    AppointmentController appointmentController = new AppointmentController();
    Appointment retrievedAppointment = await appointmentController.getAppointment(generatedId);
    setState(() {
      appointment = retrievedAppointment;
    });
  }

  @override
  void initState(){
    super.initState();
    loadAppointmentData(generatedId);
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "View Appointment",
          style: new TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'OpenSans'),
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            child: const Text('Edit',style: TextStyle(fontSize: 16.0),),

            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new AddAppointment(generatedId: appointment.getId())
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
                  "Appointment Date:",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
                new Text(
                  appointment.date,
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(
                  "Appointment Time:",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
                new Text(
                  appointment.time,
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(
                  "Clinic Name:",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
                new Text(
                  appointment.clinicName,
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(
                  "Appointment Name",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
                new Text(
                  appointment.appointName,
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
              ],
            ),
            new Row(
              children: <Widget>[
                new Text(
                  "Documents to bring:",
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
                new Text(
                  appointment.documents,
                  style: new TextStyle(
                      color: Colors.black54, fontSize: 20, fontFamily: 'OpenSans'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}