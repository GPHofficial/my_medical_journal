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

  void addAppointment(Appointment appointment){
    firestore.createDocument(appointment);
  }

  Future<Appointment> getAppointment(String generatedId) async{
    Map<String,dynamic> appointmentMap = (await firestore.getDocument(generatedId));
    Appointment appointment = Appointment.castFromMap(appointmentMap);
    return appointment;
  }

  Future<Appointment> editAppointment(Appointment updateAppointment) async{
    Map<String,dynamic> appointmentMap = (await firestore.updateDocument(updateAppointment));
    Appointment appointment = Appointment.castFromMap(appointmentMap);
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

  static List<Appointment> castAppointmentList(List<Map<String,dynamic>> appointmentMap){
    List<Appointment> appointmentList = new List<Appointment>();
    for(var appointment in appointmentMap){
      appointmentList.add(Appointment.castFromMap(appointment));
    }
    return appointmentList;
  }

  static void callAppointmentObserver(QuerySnapshot qs){
    List<Map<String,dynamic>> snapshotList = FirestoreAdapter.castSnapshotList(qs.documents);
    List<Appointment> appointmentList = castAppointmentList(snapshotList);
    for(var func in AppointmentController.observers){
      func(appointmentList);
    }
  }
}
