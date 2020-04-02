import 'package:my_medical_journal/adapters/firestore.dart';
import 'package:my_medical_journal/entities/clinic.dart';

class ClinicController{

  FirestoreAdapter<Clinic> firestore;

  ClinicController(){
     firestore = new FirestoreAdapter<Clinic>(Clinic.collectionName);
  }

  // Future<List<Clinic>> queryClinicByLocation(double ne_lat, double ne_long, double sw_lat, double sw_long) async {
  //   List<Map<String,dynamic>> clinicMap = await firestore.searchLatLngBounds(ne_lat, ne_long, sw_lat, sw_long);
  //   List<Clinic> clinicList = new List<Clinic>();
  //   for(var clinic in clinicMap){
  //     Clinic newClinic = Clinic.castFromMap(clinic);
  //     if(newClinic.LATITUDE > sw_lat && newClinic.LATITUDE < ne_lat)
  //       clinicList.add(new Clinic.castFromMap(clinic));
  //   }
  //   return clinicList;
  // }

  Future<List<Clinic>> queryClinicByLocation(double ne_lat, double ne_long, double sw_lat, double sw_long) async {
    // List<Map<String,dynamic>> clinicMap = await firestore.searchLatLngBounds(ne_lat, ne_long, sw_lat, sw_long);
    List<Clinic> clinicList = new List<Clinic>();
    // for(var clinic in clinicMap){
      // Clinic newClinic = Clinic.castFromMap(clinic);
      // if(newClinic.LATITUDE > sw_lat && newClinic.LATITUDE < ne_lat)
      
    clinicList = (getRandomList(ne_lat, ne_long, sw_lat, sw_long,50));
    return new Future.delayed(const Duration(seconds: 1), () => clinicList);
    // }
    // return clinicList;
  }

  List<Clinic> getRandomList(double ne_lat, double ne_long, double sw_lat, double sw_long, int noOfEntry){
    double lat_tick = (ne_lat - sw_lat)/noOfEntry;
    double long_tick = (sw_long - ne_long)/noOfEntry;
    List<Clinic> clinicList = new List<Clinic>();
    for (int i = 0;i<noOfEntry;i++){
      clinicList.add(getRandomData(lat_tick * i + sw_lat, long_tick * i + ne_long, i.toString()));
    }

    return clinicList;
  }

  Clinic getRandomData(lat,long,name){
    Clinic tempdata = new Clinic();
    
    tempdata.HCI_CODE = name;
    tempdata.HCI_NAME = name;
    tempdata.LICENCE_TYPE = 'MC';
    tempdata.HCI_TEL = '67624180';
    tempdata.POSTAL_CD = '680137';
    tempdata.ADDR_TYPE = null;
    tempdata.BLK_HSE_NO = '137';
    tempdata.FLOOR_NO = '01';
    tempdata.UNIT_NO = '313';
    tempdata.STREET_NAME = 'TECK WHYE LANE';
    tempdata.BUILDING_NAME = null;
    tempdata.CLINIC_PROGRAMME_CODE = 'CDMP;CHAS';
    tempdata.X_COORDINATE = '19004.10783338';
    tempdata.Y_COORDINATE = '40224.31266992';
    tempdata.INC_CRC = 'EE932469866D780D';
    tempdata.FMEL_UPD_D = '20200312125115';
    tempdata.LATITUDE = lat;
    tempdata.LONGITUDE = long;
    tempdata.id = tempdata.HCI_CODE;

    return tempdata;
  }

  

}
