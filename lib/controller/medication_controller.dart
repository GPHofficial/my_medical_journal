import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_medical_journal/adapters/firestore.dart';
import 'package:my_medical_journal/entities/medication.dart';

class MedicationController{

  FirestoreAdapter<Medication> firestore;
  static List<Function> observers;

  MedicationController(){
     firestore = new FirestoreAdapter<Medication>(Medication.collectionName);
     observers = new List<Function>();
     listenObservers();
  }

  void addMedication(Medication medication){
    firestore.createDocument(medication);
  }

  Future<Medication> getMedication(String generatedId) async{
    Map<String,dynamic> medicationMap = (await firestore.getDocument(generatedId));
    Medication medication = Medication.castFromMap(medicationMap);
    return medication;
  }

  Future<Medication> editMedication(Medication updateMedication) async{
    Map<String,dynamic> medicationMap = (await firestore.updateDocument(updateMedication));
    Medication medication = Medication.castFromMap(medicationMap);
    return medication;
  }

  Future<List<Medication>> listMedication() async{
    return castMedicationList(await firestore.listDocument());
  }

  void addMedicationObserver(Function func){
    observers.add(func);
  }

  void listenObservers(){
    firestore.listenCollection((QuerySnapshot qs){
      MedicationController.callMedicationObserver(qs);
    });
  }

  static List<Medication> castMedicationList(List<Map<String,dynamic>> medicationMap){
    List<Medication> medicationList = new List<Medication>();
    for(var medication in medicationMap){
      medicationList.add(Medication.castFromMap(medication));
    }
    return medicationList;
  }

  static void callMedicationObserver(QuerySnapshot qs){
    List<Map<String,dynamic>> snapshotList = FirestoreAdapter.castSnapshotList(qs.documents);
    List<Medication> medicationList = castMedicationList(snapshotList);
    for(var func in MedicationController.observers){
      func(medicationList);
    }
  }
}
