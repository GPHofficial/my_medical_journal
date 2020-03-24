// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:my_medical_journal/adapters/firestore.dart';

// class FirestoreQuery extends FirestoreAdapter{

//   String QueryString;

//   // Query createQueryFromString(String query){
//   //   String test = "SELECT * FROM CollectionName WHERE Test == '123'";
//   // }

//   // static Firestore firestore;
//   // static FirebaseUser user;
//   static Firestore firestoreInstance;

//   Query where(String collection, dynamic field, {
//     dynamic isEqualTo,
//     dynamic isLessThan,
//     dynamic isLessThanOrEqualTo,
//     dynamic isGreaterThan,
//     dynamic isGreaterThanOrEqualTo,
//     dynamic arrayContains,
//     List<dynamic> arrayContainsAny,
//     List<dynamic> whereIn,
//     bool isNull,
//   }) {
//     return firestoreInstance.collection(collection).where(field,
//      isEqualTo: isEqualTo,
//      isLessThan: isLessThan,
//      isLessThanOrEqualTo: isLessThanOrEqualTo,
//      isGreaterThan: isGreaterThan,
//      isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
//      arrayContains: arrayContains,
//      arrayContainsAny: arrayContainsAny,
//      whereIn: whereIn,
//      isNull: isNull
//   );
//       // return  cloud_firestore.toString();
//     //   .where(
//     //   dynamic field, {
//     //   dynamic isEqualTo,
//     //   dynamic isLessThan,
//     //   dynamic isLessThanOrEqualTo,
//     //   dynamic isGreaterThan,
//     //   dynamic isGreaterThanOrEqualTo,
//     //   dynamic arrayContains,
//     //   List<dynamic> arrayContainsAny,
//     //   List<dynamic> whereIn,
//     //   bool isNull,
//     // });
//   }

// //   QuerySnapshot results = await firestoreInstance
// //         .collection('books')
// //         .where("title", isEqualTo: "title")
// //         .getDocuments();
// // }


