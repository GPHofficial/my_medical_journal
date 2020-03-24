import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_medical_journal/entities/clinic.dart';
import '../entities/entity_base.dart';
import 'package:reflectable/reflectable.dart';
// import 'main.reflectable.dart'; 

class FirestoreAdapter<T extends EntityBase>{

  static Firestore firestore;
  static FirebaseUser user;
  static Firestore firestoreInstance;
  String collectionName;
  
  // set without merge will overwrite a document or create it if it doesn't exist yet
  // set with merge will update fields in the document or create it if it doesn't exists
  // update will update fields but will fail if the document doesn't exist
  // create will create the document but fail if the document already exists

  FirestoreAdapter(String collectionName){
    this.collectionName = collectionName; 
    getUserDetails();
    initializeFirestore();
  }

  void getUserDetails() async{
    if(user == null){
      FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      user = await _firebaseAuth.currentUser();
    }
  }

  void initializeFirestore() async{
    if(firestoreInstance == null){
      firestore = Firestore();
      firestoreInstance = Firestore.instance;
    }
  }

  Future<Map<String,dynamic>> updateDocument(EntityBase updateData) async {

    String generatedId = updateData.getId();
    Map<String,dynamic> extractedUpdateData = updateData.getData();

    await firestoreInstance
        .collection(collectionName)
        .document(generatedId)
        .updateData(extractedUpdateData);

    return (await getDocument(generatedId));
  }

  Future<void> deleteDocument(String generatedId) async {
    await firestoreInstance.collection(collectionName).document(generatedId).delete();
  }

  Future<List<Map<String,dynamic>>> listDocument() async {
    QuerySnapshot results = await firestoreInstance
        .collection(collectionName)
        .getDocuments();

     return castSnapshotList(results.documents.toList());
  }

  // Future<void> searchDocument() async {
  //   QuerySnapshot results = await firestoreInstance
  //       .collection('books')
  //       .where("title", isEqualTo: "title")
  //       .getDocuments();
    // .catchError((e) => setState(() {
    //       _firebaseCheckStatus = -1;
    //     }));

    // List<DocumentSnapshot> docList = results.documents.toList();
    // DocumentSnapshot value = docList.firstWhere((doc) {
    //   return doc.documentID == generatedId;
    // }, orElse: () => null);
  // }

  Future<Map<String,dynamic>> getDocument(String generatedId) async {
    DocumentSnapshot ds = await firestoreInstance
        .collection(collectionName)
        .document(generatedId)
        .get();

    return FirestoreAdapter.castSnapshot(ds);
    
  }

  Future<String> createDocument(EntityBase newDocument) async {
    //Create
    String className = collectionName;
    Map<String,dynamic> extractedData = newDocument.getData();
    DocumentReference generatedDocRef = await firestoreInstance
        .collection(className)
        .add(extractedData);

    return generatedDocRef.documentID;
  }

  Future<String> createOrUpdateDocument(EntityBase newDocument) async {
    String generatedId = newDocument.getId();
    if(generatedId == null){
      generatedId = await createDocument(newDocument);
    }
    
    Map<String,dynamic> extractedData = newDocument.getData();

    await firestore.collection(collectionName).document(generatedId).setData(extractedData,merge: true);
    return generatedId;
  }

  Future<List<Map<String,dynamic>>> searchLatLngBounds(double ne_lat, double ne_long, double sw_lat, double sw_long) async{
    GeoPoint ne = GeoPoint(ne_lat,ne_long);
    GeoPoint sw = GeoPoint(sw_lat,sw_long);
    return searchGeoPoints(ne, sw);
  }

  // Future<List<Clinic>> searchGeoPoints(double lat, double long, double distance) async{
  Future<List<Map<String,dynamic>>> searchGeoPoints(GeoPoint northeast, GeoPoint southwest) async{
    CollectionReference collectionRef = firestore.collection("clinic");
    Query query = collectionRef.where("LATITUDE", isGreaterThan: southwest.longitude, isLessThan: northeast.longitude);
    // query = collectionRef.where("LATITUDE", isGreaterThan: southwest.latitude, isLessThan: northeast.latitude);
    QuerySnapshot snapshot = await query.getDocuments();

    List<DocumentSnapshot> docList = snapshot.documents.toList();
    List<Clinic> clinic = new List<Clinic>();
    List<Map<String,dynamic>> mapList = castSnapshotList(docList);
    return mapList;
  }

  static List<Map<String,dynamic>> castSnapshotList(List<DocumentSnapshot> snapshots){
    // List<DocumentSnapshot> docList = snapshot.documents.toList();
    List<Map<String,dynamic>> list = new List<Map<String,dynamic>>();
    for (var doc in snapshots) {
      list.add(castSnapshot(doc));
    }
    return list;
  }

  static Map<String,dynamic> castSnapshot(DocumentSnapshot snapshot){
    Map<String,dynamic> item = snapshot.data;
    item["id"] = snapshot.documentID;
    return item;
  }



  Future<void> listenCollection(Function function) async {
    //Listen (Runs whenever there's changes to documents)
    firestoreInstance
        .collection(collectionName)
        .snapshots()
        .listen(function);

        
  }
}
