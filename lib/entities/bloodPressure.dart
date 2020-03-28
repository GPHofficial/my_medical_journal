import 'entity_base.dart';

class BloodPressure implements EntityBase {
  static String collectionName = "BloodPressure";
  String _diastolic;
  String _systolic;
  String _heartRate;
  String _date;
  String _time;
  String id;

  BloodPressure();
  BloodPressure.set(this._diastolic,this._systolic,this._heartRate,this._date,this._time);
  BloodPressure.defaults(){
    this.id ="";
    this._diastolic ="";
    this._systolic ="";
    this._heartRate ="";
    this._date ="";
    this._time ="";
  }
  String get diastolic => _diastolic;
  String get systolic => _systolic;
  String get heartRate => _heartRate;
  String get date => _date;
  String get time => _time;
  void setId(String id){
    this.id = id;
  }

  String getId(){
    return this.id;
  }
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

  Map<String,dynamic> getData(){
    Map<String,dynamic> data = {
      "Diastolic": this._diastolic,
      "Systolic": this._systolic,
      "Heart Rate": this._heartRate,
      "Date": this._date,
      "Time": this._time,

    };
    return data;
  }

  BloodPressure.castFromMap(Map<String,dynamic> map){
    this._diastolic = map["Diastolic"];
    this._systolic = map["Systolic"];
    this._heartRate = map["Heart Rate"];
    this._date = map["Date"];
    this._time = map["Time"];
    this.id = map["id"];
  }
  
  void disp(){
    print("Diastolic: "+ diastolic);
    print("Systolic: "+ systolic);
    print("Heart Rate: "+ heartRate);
    print("Date: "+ date);
    print("Time: "+ time);
  }
}