class Appointment {
  String _Date;
  String _Time;
  String _c_name;
  String _a_name;
  String _documents;
  List<String> _reminders;
  List<String> _specialInfo;

  Appointment();
  String get Date=> _Date;
  String get Time=> _Time;
  String get clinicName=> _c_name;
  String get appointmentName=> _a_name;
  String get Documents=> _documents;

  List<String> get reminders=>_reminders;
  List<String> get specialInfo=>_specialInfo;

  void setDate(String Date){
    this._Date = Date;
  }
  void setTime(String Time){
    this._Time = Time;
  }
  void setclinicName(String clinicName){
    this._c_name = clinicName;
  }
  void setAppointmentName(String appointmentName){
    this._a_name = appointmentName;
  }
  void setDocuments(String Documents){
    this._documents= Documents;
  }
  void setReminders(List<String> reminders){
    this._reminders = reminders;
  }
  void setSpecialInfo(List<String> specialInfo){
    this._specialInfo = specialInfo;
  }

  void disp(){
    print("Appointment Date: "+_Date);
    print("Appointment Time: "+_Time);
    print("Clinic Name: "+ _c_name);
    print("Appointment Name: "+_a_name);
    print("Documents: "+_documents);
  }



}
