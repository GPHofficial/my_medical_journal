import 'entities/medication.dart';
import 'dart:convert';
import 'dart:io';
import 'medication_db.dart';

class MedicationManager{

  int index;
  MedicationDB medicationDB = new MedicationDB();


  Medication addMedication(String _medication, String _nickname, int _dosage, int _frequency, int _quantity)
  {
    //Medication newMedication = new Medication.withInfo(_medication, _nickname, _reminders, _dosage, _frequency, _quantity, _specialInfo);

    Map<String,dynamic> write = new Map();
    write['Name'] = _medication;
    write['Nickname'] = _nickname;
    write['Dosage'] = _dosage;
    write['Frequency'] = _frequency;
    write['Quantitiy'] = _quantity;
    print(write);
    if(medicationDB.fileExists){
      medicationDB.writeToFile(write);
      print(medicationDB.fileContent.toString());
    }
    else{
      medicationDB.createFile(write);
      print("try Again no File!");
    }
  }

}