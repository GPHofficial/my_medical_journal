import 'package:my_medical_journal/adapters/firestore.dart';
import 'package:my_medical_journal/entities/user.dart';

class UserController{

  FirestoreAdapter<User> firestore;

  UserController(){
     firestore = new FirestoreAdapter<User>();
  }

  void addOrUpdateUser(String id,String name, String email, String picture){
    User currentUser = User.setAll(email, name, picture);
    currentUser.id = id;
    firestore.createOrUpdateDocument(currentUser);
  }
}