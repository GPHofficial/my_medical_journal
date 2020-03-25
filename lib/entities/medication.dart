import 'package:my_medical_journal/adapters/firestore.dart';
import 'package:my_medical_journal/entities/entity_base.dart';

class Medication implements EntityBase{

  static String collectionName = "medication";
  String id;
  String _medication;
  String _nickname;
  List<String> _reminders;
  int _dosage;
  int _frequency;
  int _quantity;
  List<String> _specialInfo;

  Medication();
  Medication.set(this._medication,this._nickname,this._reminders,this._dosage,this._frequency,this._quantity,this._specialInfo);
  Medication.defaults(){
    this.id = "";
    this._medication = "";
    this._nickname = "";
    this._reminders = new List<String>();
    this._dosage = 0;
    this._frequency = 0;
    this._quantity = 0;
    this._specialInfo = new List<String>();
  }
  String get medication=> _medication;
  String get nickname=> _nickname;
  int get dosage=> _dosage;
  int get frequency=> _frequency;
  int get quantity=> _quantity;

  List<String> get reminders=>_reminders;
  List<String> get specialInfo=>_specialInfo;

  void setId(String id){
    this.id = id;
  }

  String getId(){
    return this.id;
  }

  void setName(String medication){
    this._medication = medication;
  }
  void setNickname(String medication){
    this._nickname = medication;
  }
  void setDosage(int medication){
    this._dosage = medication;
  }
  void setFrequency(int medication){
    this._frequency = medication;
  }
  void setQuantity(int medication){
    this._quantity= medication;
  }
  void setReminders(List<String> medication){
    this._reminders = medication;
  }
  void setSpecialInfo(List<String> medication){
    this._specialInfo = medication;
  }

  void disp(){
    print("Medication Name: "+_medication);
    print("Medication NickName: "+_nickname);
    print("Medication Dosage: "+ _dosage.toString());
    print("Medication Frequency: "+_frequency.toString());
    print("Medication Quantity: "+_quantity.toString());
  }

  Map<String,dynamic> getData(){
    Map<String,dynamic> data = {
      "medication": this._medication,
      "nickname": this._nickname,
      "dosage": this._dosage,
      "frequency": this._frequency,
      "quantity": this._quantity,
      "reminders": this._reminders,
      "specialInfo": this._specialInfo,
    };
    return data;
  }

  Medication.castFromMap(Map<String,dynamic> map){
    this._medication = map["medication"];
    this._nickname = map["nickname"];
    this._dosage = map["dosage"];
    this._frequency = map["frequency"];
    this._quantity = map["quantity"];
    this._reminders = map["reminders"];
    this._specialInfo = map["specialInfo"];
    this.id = map["id"];
  }
    
  


}