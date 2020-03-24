import 'package:my_medical_journal/adapters/firestore.dart';
import 'package:my_medical_journal/entities/clinic.dart';

class ClinicController{

  FirestoreAdapter<Clinic> firestore;

  ClinicController(){
     firestore = new FirestoreAdapter<Clinic>(Clinic.collectionName);
  }

  Future<List<Clinic>> queryClinicByLocation(double ne_lat, double ne_long, double sw_lat, double sw_long) async {
    List<Map<String,dynamic>> clinicMap = await firestore.searchLatLngBounds(ne_lat, ne_long, sw_lat, sw_long);
    List<Clinic> clinicList = new List<Clinic>();
    for(var clinic in clinicMap){
      Clinic newClinic = Clinic.castFromMap(clinic);
      if(newClinic.LATITUDE > sw_lat && newClinic.LATITUDE < ne_lat)
        clinicList.add(new Clinic.castFromMap(clinic));
    }
    return clinicList;
  }
}
