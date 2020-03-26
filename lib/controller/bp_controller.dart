
import 'package:cloud_firestore/cloud_firestore.dart';

import '../adapters/firestore.dart';
import '../entities/bloodPressure.dart';

class BpController{
  FirestoreAdapter<BloodPressure> firestore;
  static List<Function> observers;

    BpController(){
     firestore = new FirestoreAdapter<BloodPressure>(BloodPressure.collectionName);
     observers = new List<Function>();
     listenObservers();
    }

    void addBp(BloodPressure bp){
    firestore.createDocument(bp);
    }

    //get all bp unique id
    Future<List> getBpId() async{
      QuerySnapshot result =
          await Firestore.instance.collection('BloodPressure').getDocuments();
      List<DocumentSnapshot> bpdoc = result.documents;
      return bpdoc;
    }

    Future<BloodPressure> getBp(String generatedId) async{
    Map<String,dynamic> bpMap = (await firestore.getDocument(generatedId));
    BloodPressure bp = BloodPressure.castFromMap(bpMap);
    return bp;
    }

    Future<List<BloodPressure>> listBp() async{
    return castBpList(await firestore.listDocument());
    }

    void addBpObserver(Function func){
      observers.add(func);
    }

    void listenObservers(){
      firestore.listenCollection((QuerySnapshot qs){
      BpController.callBpObserver(qs);
      });
    }

    static List<BloodPressure> castBpList(List<Map<String,dynamic>> bpMap){
      List<BloodPressure> bpList = new List<BloodPressure>();
      for(var bp in bpMap){
        bpList.add(BloodPressure.castFromMap(bp));
      }
      return bpList;
    }

    static void callBpObserver(QuerySnapshot qs){
      List<Map<String,dynamic>> snapshotList = FirestoreAdapter.castSnapshotList(qs.documents);
      List<BloodPressure> bpList = castBpList(snapshotList);
      for(var func in BpController.observers){
        func(bpList);
      }
    }

}