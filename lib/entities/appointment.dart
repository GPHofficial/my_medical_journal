import 'package:my_medical_journal/adapters/firestore.dart';
import 'package:my_medical_journal/entities/entity_base.dart';

class Appointment implements EntityBase{
  String id;
  static String collectionName = "Appointment";
  String _Date;
  String _Time;
  String _c_name;
  String _a_name;
  String _documents;
  List<String> _reminders;
  List<String> _specialInfo;

  Appointment();
  Appointment.set(this._Date,this._Time,this._reminders,this._c_name,this._a_name,this._documents,this._specialInfo);
  Appointment.defaults(){
    this._Date = "";
    this._Time = "";
    this._c_name = "";
    this._a_name = "";
    this._documents = "";
    this._reminders = new List<String>();
    this._specialInfo = new List<String>();
  }
  String get date => _Date;
  String get time=> _Time;
  String get clinicName=> _c_name;
  String get appointName=> _a_name;
  String get documents=> _documents;

  List<String> get reminders=>_reminders;
  List<String> get specialInfo=>_specialInfo;

  void setId(String id){
    this.id = id;
  }

  String getId(){
    return this.id;
  }

  void setDate(String date){
    this._Date = date;
  }
  void setClinicName(String clinicName){
    this._c_name = clinicName;
  }
  void setAppointName(String appointName){
    this._a_name = appointName;
  }
  void setTime(String Time){
    this._Time = Time;
  }

  void setDocuments(String documents){
    this._documents = documents;
  }
  void setReminders(List<String> Appointment){
    this._reminders = Appointment;
  }
  void setSpecialInfo(List<String> Appointment){
    this._specialInfo = Appointment;
  }

  void disp(){
    print("Appointment Date: "+_Date);
    print("Appointment Time: "+_Time);
    print("Clinic Name: "+ _c_name);
    print("Appointment Name: "+_a_name);
    print("Documents to bring: "+_documents);
  }

  Map<String,dynamic> getData(){
    Map<String,dynamic> data = {
      "Appointment Date": this._Date,
      "Appointment Time": this._Time,
      "Clinic Name": this._c_name,
      "Appointment Name": this._a_name,
      "Documents to bring": this._documents,
      "reminders": this._reminders,
      "specialInfo": this._specialInfo,
    };
    return data;
  }

  Appointment.castFromMap(Map<String,dynamic> map){
    this._Date = map["Appointment Date"];
    this._Time = map["Appointment Time"];
    this._c_name = map["Clinic Name"];
    this._a_name = map["Appointment Name"];
    this._documents = map["Documents to bring"];
    this._reminders = map["reminders"];
    this._specialInfo = map["specialInfo"];
    this.id = map["id"];
  }





}
