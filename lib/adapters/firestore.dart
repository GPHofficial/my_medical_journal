import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_medical_journal/entities/clinic.dart';
import '../entities/entity_base.dart';
class FirestoreAdapter<T extends EntityBase>{
  static Firestore firestore;
  static FirebaseUser user;
  static Firestore firestoreInstance;
  
  FirestoreAdapter(){
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




    // set without merge will overwrite a document or create it if it doesn't exist yet
    // set with merge will update fields in the document or create it if it doesn't exists
    // update will update fields but will fail if the document doesn't exist
    // create will create the document but fail if the document already exists

  Future<EntityBase> updateDocument(EntityBase updateData) async {

    String generatedId = updateData.getId();
    Map<String,dynamic> extractedUpdateData = updateData.getNewData();

    await firestoreInstance
        .collection(updateData.collectionName)
        .document(generatedId)
        .updateData(extractedUpdateData);

    await getDocument(updateData.collectionName, generatedId);
  }

  Future<void> deleteDocument(String generatedId) async {
    await firestoreInstance.collection('books').document(generatedId).delete();
  }

  Future<void> searchDocument() async {
    QuerySnapshot results = await firestoreInstance
        .collection('books')
        .where("title", isEqualTo: "title")
        .getDocuments();
    // .catchError((e) => setState(() {
    //       _firebaseCheckStatus = -1;
    //     }));

    List<DocumentSnapshot> docList = results.documents.toList();
    // DocumentSnapshot value = docList.firstWhere((doc) {
    //   return doc.documentID == generatedId;
    // }, orElse: () => null);
  }

  Future<T> getDocument(String collection, String generatedId) async {
    await firestoreInstance
        .collection(collection)
        .document(generatedId)
        .get()
        .then((DocumentSnapshot ds) {
          if (ds.documentID == generatedId && ds.data != null) {
            return ds.data;
          } else {
            return new Exception("Can't find Document: " + generatedId + " in collection: " + collection);
          }
    });
  }

  Future<String> createDocument(EntityBase newDocument) async {
    //Create
    String className = newDocument.collectionName;
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
    String className = newDocument.collectionName;
    Map<String,dynamic> extractedData = newDocument.getData();

    await firestore.collection(className).document(generatedId).setData(extractedData,merge: true);
    return generatedId;
  }

  Future<List<Clinic>> searchLatLngBounds(double ne_lat, double ne_long, double sw_lat, double sw_long) async{
    GeoPoint ne = GeoPoint(ne_lat,ne_long);
    GeoPoint sw = GeoPoint(sw_lat,sw_long);
    return searchGeoPoints(ne, sw);
  }

  // Future<List<Clinic>> searchGeoPoints(double lat, double long, double distance) async{
  Future<List<Clinic>> searchGeoPoints(GeoPoint northeast, GeoPoint southwest) async{
    CollectionReference collectionRef = firestore.collection("clinic");
    Query query = collectionRef.where("LATITUDE", isGreaterThan: southwest.longitude, isLessThan: northeast.longitude);
    // query = collectionRef.where("LATITUDE", isGreaterThan: southwest.latitude, isLessThan: northeast.latitude);
    QuerySnapshot snapshot = await query.getDocuments();

    List<DocumentSnapshot> docList = snapshot.documents.toList();
    List<Clinic> clinic = new List<Clinic>();
    for (var doc in docList) {
      Clinic newClinic = Clinic.castFromMap(doc.data);
      newClinic.setId(doc.documentID);
      print(northeast.latitude);
      if(newClinic.LATITUDE > southwest.latitude && newClinic.LATITUDE < northeast.latitude)
        clinic.add(newClinic);
    }
    print(clinic.length);
    return clinic;
  }

  // Future<void> listenCollection(String generatedId) async {
  //   //Listen (Runs whenever there's changes to documents)
  //   firestoreInstance
  //       .collection('books')
  //       .where("title", isEqualTo: "title")
  //       .snapshots()
  //       .listen((data) => data.documents.forEach((doc) => {
  //             if (doc.documentID == generatedId)
  //               {print("Listen DocumentId found: " + generatedId)}
  //           }));
  // }
}
