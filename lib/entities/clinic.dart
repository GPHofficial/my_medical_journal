import 'package:my_medical_journal/adapters/firestore.dart';
import 'package:my_medical_journal/entities/entity_base.dart';

class Clinic implements EntityBase{

  static String collectionName = "clinic";

  String id;
  String ADDR_TYPE ;
  String BLK_HSE_NO ;
  String BUILDING_NAME;
  String CLINIC_PROGRAMME_CODE ;
  String FLOOR_NO ;
  String FMEL_UPD_D ;
  String HCI_CODE ;
  String HCI_NAME ;
  String HCI_TEL ;
  String INC_CRC ;
  double LATITUDE;
  String LICENCE_TYPE ;
  double LONGITUDE;
  String POSTAL_CD ;
  String STREET_NAME ;
  String UNIT_NO ;
  String X_COORDINATE ;
  String Y_COORDINATE ;

  Clinic.setAll(
    this.ADDR_TYPE,
    this.BLK_HSE_NO,
    this.BUILDING_NAME,
    this.CLINIC_PROGRAMME_CODE,
    this.FLOOR_NO,
    this.FMEL_UPD_D,
    this.HCI_CODE,
    this.HCI_NAME,
    this.HCI_TEL,
    this.INC_CRC,
    this.LATITUDE,
    this.LICENCE_TYPE,
    this.LONGITUDE,
    this.POSTAL_CD,
    this.STREET_NAME,
    this.UNIT_NO,
    this.X_COORDINATE,
    this.Y_COORDINATE,
  );

  Clinic.castFromMap(Map<String,dynamic> map){

    this.ADDR_TYPE = map["ADDR_TYPE"];
    this.BLK_HSE_NO = map["BLK_HSE_NO"];
    this.BUILDING_NAME = map["BUILDING_NAME"];
    this.CLINIC_PROGRAMME_CODE = map["CLINIC_PROGRAMME_CODE"];
    this.FLOOR_NO = map["FLOOR_NO"];
    this.FMEL_UPD_D = map["FMEL_UPD_D"];
    this.HCI_CODE = map["HCI_CODE"];
    this.HCI_NAME = map["HCI_NAME"];
    this.HCI_TEL = map["HCI_TEL"];
    this.INC_CRC = map["INC_CRC"];
    
    this.LICENCE_TYPE = map["LICENCE_TYPE"];
    
    this.POSTAL_CD = map["POSTAL_CD"];
    this.STREET_NAME = map["STREET_NAME"];
    this.UNIT_NO = map["UNIT_NO"];
    this.X_COORDINATE = map["X_COORDINATE"];
    this.Y_COORDINATE = map["Y_COORDINATE"];

    this.LONGITUDE = map["LATITUDE"];
    this.LATITUDE = map["LONGITUDE"];

  }

  String setId(String id){
    this.id = id;
  }

  String getId(){
    return id;
  }

  Map<String,dynamic> getData(){}
  Map<String,dynamic> getNewData(){}

}
