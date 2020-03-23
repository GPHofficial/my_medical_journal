import 'package:my_medical_journal/adapters/firestore.dart';
import 'package:my_medical_journal/entities/entity_base.dart';

class User extends FirestoreAdapter implements EntityBase{


  String collectionName = "user";
  String email;
  String name;
  String picture;
  String id;

  User oldData;

  User();
  User.set(this.email,this.name);
  User.setAll(this.email,this.name,this.picture);

  void setId(String id){
    this.id = id;
  }

  set setName(String name){
    this.name = name;
  }

  set setEmail(String email){
    this.email = email;
  }

  String getId(){
    return this.id;
  }

  String getName(){
    return this.name;
  }

  String getEmail(){
    return this.email;
  }

  Map<String,dynamic> getData(){
    Map<String,dynamic> data = {
      "name": this.name,
      "email": this.email,
      "picture": this.picture,
    };

    return data;
  }

  Map<String,dynamic> getNewData(){
    Map<String,dynamic> data = getData();
    if(this.name == null){
      data.remove("name");
    }
    if(this.email != null){
      data.remove("email");
    }
    if(this.picture != null){
      data.remove("picture");
    }

    return data;
  }


}