import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreAdapter {
  static Firestore firestore = Firestore();
  final Firestore _firestore = Firestore.instance;

  FirestoreAdapter() {}

  Future<void> updateDocument(String generatedId) async {
    await _firestore
        .collection('books')
        .document(generatedId)
        .updateData({'author': 'not author'});

    await _firestore
        .collection('books')
        .document(generatedId)
        .get()
        .then((DocumentSnapshot ds) {
      if (ds.documentID == generatedId) {
        if (ds.data['author'] == "not author") {
          print("Updated DocumentId found: " + generatedId);
        } else {
          // setState(() {
          //   _firebaseCheckStatus = -1;
          // });
        }
      }
    });
    // .catchError((e) => setState(() {
    //           _firebaseCheckStatus = -1;
    //         }));
  }

  Future<void> deleteDocument(String generatedId) async {
    // //Delete
    await _firestore.collection('books').document(generatedId).delete();
    //Delete Check
    await _firestore
        .collection('books')
        .document(generatedId)
        .get()
        .then((DocumentSnapshot ds) {
      if (ds.data != null) {
        // setState(() {
        //   _firebaseCheckStatus = -1;
        // });
      } else {
        print("Deleted DocumentId: " + generatedId);
      }
    });
  }

  Future<void> searchDocument() async {
    QuerySnapshot results = await _firestore
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

  Future<void> getDocument(String collection, String generatedId) async {
    await _firestore
        .collection('books')
        .document(generatedId)
        .get()
        .then((DocumentSnapshot ds) {
      if (ds.documentID == generatedId && ds.data != null) {
        print("Get DocumentId found: " + generatedId);
      } else {
        //Get Document Failed
      }
    });
    // .catchError((e) => print(() {
    //           // _firebaseCheckStatus = -1;
    //           //exception is e
    //         }));
  }

  Future<void> createDocument() async {
    //Create
    DocumentReference generatedDocRef = await _firestore
        .collection('books')
        .add({'title': 'title', 'author': 'author'});

    // .catchError(
    //     (e) => setState(() {
    //           _firebaseCheckStatus = -1;
    //         }));

    String generatedId = generatedDocRef.documentID;
    print("Created DocumentId: " + generatedId);
  }

  Future<void> listenCollection(String generatedId) async {
    //Listen (Runs whenever there's changes to documents)
    _firestore
        .collection('books')
        .where("title", isEqualTo: "title")
        .snapshots()
        .listen((data) => data.documents.forEach((doc) => {
              if (doc.documentID == generatedId)
                {print("Listen DocumentId found: " + generatedId)}
            }));
  }
}
