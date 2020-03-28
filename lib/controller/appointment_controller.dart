import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_medical_journal/adapters/firestore.dart';
import 'package:my_medical_journal/entities/appointment.dart';

class AppointmentController{

  FirestoreAdapter<Appointment> firestore;
  static List<Function> observers;

  AppointmentController(){
    firestore = new FirestoreAdapter<Appointment>(Appointment.collectionName);
    observers = new List<Function>();
    listenObservers();
  }

  void addAppointment(Appointment Appointment){
    firestore.createDocument(Appointment);
  }

  Future<Appointment> getAppointment(String generatedId) async{
    Map<String,dynamic> AppointmentMap = (await firestore.getDocument(generatedId));
    Appointment appointment = Appointment.castFromMap(AppointmentMap);
    return appointment;
  }

  Future<Appointment> editAppointment(Appointment updateAppointment) async{
    Map<String,dynamic> AppointmentMap = (await firestore.updateDocument(updateAppointment));
    Appointment appointment = Appointment.castFromMap(AppointmentMap);
    return appointment;
  }

  Future<List<Appointment>> listAppointment() async{
    return castAppointmentList(await firestore.listDocument());
  }

  void addAppointmentObserver(Function func){
    observers.add(func);
  }

  void listenObservers(){
    firestore.listenCollection((QuerySnapshot qs){
      AppointmentController.callAppointmentObserver(qs);
    });
  }

  static List<Appointment> castAppointmentList(List<Map<String,dynamic>> AppointmentMap){
    List<Appointment> AppointmentList = new List<Appointment>();
    for(var Appointment in AppointmentMap){
      AppointmentList.add(Appointment.castFromMap(Appointment));
    }
    return AppointmentList;
  }

  static void callAppointmentObserver(QuerySnapshot qs){
    List<Map<String,dynamic>> snapshotList = FirestoreAdapter.castSnapshotList(qs.documents);
    List<Appointment> AppointmentList = castAppointmentList(snapshotList);
    for(var func in AppointmentController.observers){
      func(AppointmentList);
    }
  }
}
