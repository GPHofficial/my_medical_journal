class Medication {
  String _medication;
  String _nickname;
  List<String> _reminders;
  int _dosage;
  int _frequency;
  int _quantity;
  List<String> _specialInfo;

  Medication();
  Medication.withInfo(this._medication,this._nickname,this._reminders,this._dosage,this._frequency,this._quantity,this._specialInfo);
  String get medication=> _medication;
  String get nickname=> _nickname;
  int get dosage=> _dosage;
  int get frequency=> _frequency;
  int get quantity=> _quantity;

  List<String> get reminders=>_reminders;
  List<String> get specialInfo=>_specialInfo;

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



}