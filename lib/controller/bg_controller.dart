import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_medical_journal/adapters/firestore.dart';
import 'package:my_medical_journal/entities/bloodGlucose.dart';

class BgController{
  FirestoreAdapter<BloodGlucose> firestore;
  static List<Function> observers;

    BgController(){
     firestore = new FirestoreAdapter<BloodGlucose>(BloodGlucose.collectionName);
     observers = new List<Function>();
     listenObservers();
    }

    void addBg(BloodGlucose bg){
    firestore.createDocument(bg);
    }

    Future<BloodGlucose> getBg(String generatedId) async{
    Map<String,dynamic> bgMap = (await firestore.getDocument(generatedId));
    BloodGlucose bg = BloodGlucose.castFromMap(bgMap);
    return bg;
    }

    Future<List<BloodGlucose>> listBg() async{
    return castBgList(await firestore.listDocument());
    }

    void addBgObserver(Function func){
      observers.add(func);
    }

    void listenObservers(){
      firestore.listenCollection((QuerySnapshot qs){
      BgController.callBgObserver(qs);
      });
    }

    static List<BloodGlucose> castBgList(List<Map<String,dynamic>> bgMap){
      List<BloodGlucose> bgList = new List<BloodGlucose>();
      for(var bg in bgMap){
        bgList.add(BloodGlucose.castFromMap(bg));
      }
      return bgList;
    }

    static void callBgObserver(QuerySnapshot qs){
      List<Map<String,dynamic>> snapshotList = FirestoreAdapter.castSnapshotList(qs.documents);
      List<BloodGlucose> bgList = castBgList(snapshotList);
      for(var func in BgController.observers){
        func(bgList);
      }
    }

}