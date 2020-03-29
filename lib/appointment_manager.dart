import 'entities/appointment.dart';
import 'dart:convert';
import 'dart:io';
import 'appointment_db.dart';

class AppointmentManager{

  int index;
  AppointmentDB appointmentDB = new AppointmentDB();


  Appointment addappointment(String _Date, String _Time, int _c_name, int _a_name, int _documents)
  {
    //appointment newappointment = new appointment.withInfo(_Date, String _Time, int _c_name, int _a_name, int _documents, _specialInfo);

    Map<String,dynamic> write = new Map();
    write['Date'] = _Date;
    write['Time'] = _Time;
    write['Clinic Name'] = _c_name;
    write['Appointment Name'] = _a_name;
    write['Documents'] = _documents;
    print(write);
    if(appointmentDB.fileExists){
     appointmentDB.writeToFile(write);
      print(appointmentDB.fileContent.toString());
    }
    else{
      appointmentDB.createFile(write);
      print("try Again no File!");
    }
  }

}