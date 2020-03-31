import 'entity_base.dart';

class BloodGlucose implements EntityBase {
  static String collectionName = "BloodGlucose";
  String _glucose;
  String _date;
  String _time;
  String id;

  BloodGlucose();
  BloodGlucose.set(this._glucose,this._date,this._time);
  BloodGlucose.defaults(){
    this.id ="";
    this._glucose ="";
    this._date ="";
    this._time ="";
  }
  String get glucose => _glucose;
  String get date => _date;
  String get time => _time;
  void setId(String id){
    this.id = id;
  }

  String getId(){
    return this.id;
  }
void setGlucose (String glucose){
  this._glucose = glucose;
}
void setDate (String date){
  this._date = date;
}
void setTime (String time){
  this._time = time;
}

  Map<String,dynamic> getData(){
    Map<String,dynamic> data = {
      "Glucose": this._glucose,
      "Date": this._date,
      "Time": this._time,

    };
    return data;
  }

  BloodGlucose.castFromMap(Map<String,dynamic> map){
    this._glucose = map["Glucose"];
    this._date = map["Date"];
    this._time = map["Time"];
    this.id = map["id"];
  }
  
}