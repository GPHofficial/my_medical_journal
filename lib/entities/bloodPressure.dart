class bloodPressure {
  String _diastolic;
  String _systolic;
  String _heartRate;
  String _date;
  String _time;

  bloodPressure();

  String get diastolic => _diastolic;
  String get systolic => _systolic;
  String get heartRate => _heartRate;
  String get date => _date;
  String get time => _time;

void setDiastolic (String diastolic){
  this._diastolic = diastolic;
}
void setSystolic (String systolic){
  this._systolic = systolic;
}
void setHeartrate (String heartRate){
  this._heartRate = heartRate;
}
void setDate (String date){
  this._date = date;
}
void setTime (String time){
  this._time = time;
}

  void disp(){
    print("Diastolic: "+ diastolic);
    print("Systolic: "+ systolic);
    print("Heart Rate: "+ heartRate);
    print("Date: "+ date);
    print("Time: "+ time);
  }
}