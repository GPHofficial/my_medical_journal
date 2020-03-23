import 'package:my_medical_journal/adapters/firestore.dart';
import 'package:my_medical_journal/entities/clinic.dart';

class ClinicController{

  FirestoreAdapter<Clinic> firestore;

  ClinicController(){
     firestore = new FirestoreAdapter<Clinic>();
  }

  Future<List<Clinic>> queryClinicByLocation(double ne_lat, double ne_long, double sw_lat, double sw_long) async {
    List<Clinic> clinicList = await firestore.searchLatLngBounds(ne_lat, ne_long, sw_lat, sw_long);
    return clinicList;
  }
}
