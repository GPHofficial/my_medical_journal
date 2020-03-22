import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert'; //to convert json to maps and vice versa
// import 'package:path_provider/path_provider.dart'; //add path provider dart plugin on pubspec.yaml file



class MedicationDB {

  TextEditingController keyInputController = new TextEditingController();
  TextEditingController valueInputController = new TextEditingController();

  File jsonFile;
  Directory dir;
  String fileName = "myJSONFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  MedicationDB(){
  //   getApplicationDocumentsDirectory().then((Directory directory)
  // {
  //   print("Running Constructor");
  // dir = directory;
  // jsonFile = new File(dir.path + "/" + fileName);
  // fileExists = jsonFile.existsSync();
  // if (fileExists)
  // fileContent = jsonDecode(jsonFile.readAsStringSync());
  // });
  }


  void createFile(Map<String, dynamic> content /*Directory dir, String fileName*/) {
    // print("Creating file!");
    // File file = new File(dir.path + "/" + fileName);
    // file.createSync();
    // fileExists = true;
    // file.writeAsStringSync(jsonEncode(content));
  }

  void writeToFile( Map<String, dynamic> content) {
    // print("Writing to file!");
    // if (fileExists) {
    //   print("File exists");
    //   Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
    //   jsonFileContent.addAll(content);
    //   jsonFile.writeAsStringSync(jsonEncode(jsonFileContent));
    // } else {
    //   print("File does not exist!");
    //   createFile(content);
    // }
    // fileContent = jsonDecode(jsonFile.readAsStringSync());
    // print(fileContent);
  }

  bool filexists(){
    return true;
  }

}
