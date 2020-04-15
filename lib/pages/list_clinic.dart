import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_medical_journal/controller/clinic_controller.dart';
import 'package:my_medical_journal/entities/clinic.dart';
import '../menu.dart';
class ClinicPage extends StatefulWidget {
  @override
  ClinicPageState createState() => ClinicPageState();
}

class ClinicPageState extends State<ClinicPage> {
  Completer<GoogleMapController> _controller = Completer();
  ClinicController clinicController = new ClinicController();
  List<Clinic> containerClinics = new List<Clinic>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final ScrollController lvscrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
        icon: Icon(Icons.home),
    onPressed:
    () => Navigator.of(context).push(new MaterialPageRoute(
    builder: (BuildContext context) => new MenuPage())),
        ),
    title: Text("Clinic Locator",style: new TextStyle(
        color: Colors.white, fontSize: 30, fontFamily: 'OpenSans'),),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.search),
              onPressed: () {
                //
              }),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          _buildContainer(),
        ],
      ),
    );
  }

  void mapScroll() async{
    // setState(() {
        // markers =  <MarkerId, Marker>{};
        
      // });

    final GoogleMapController controller = await _controller.future;
    LatLngBounds boundary = await controller.getVisibleRegion();

    List<Clinic> clinics = await clinicController.queryClinicByLocation(boundary.northeast.latitude,boundary.northeast.longitude, 
      boundary.southwest.latitude,boundary.southwest.longitude);

    

    setState(() {
      containerClinics = clinics;
    });

    for(var clinic in clinics){
      Marker newMarker = Marker(
        markerId: MarkerId(clinic.HCI_CODE),
        position: LatLng(clinic.LATITUDE, clinic.LONGITUDE),
        infoWindow: InfoWindow(title: clinic.HCI_NAME, snippet: clinic.LICENCE_TYPE),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet,
        ),
        onTap: () => {scrollToCard(clinic.HCI_CODE)}
      );
      MarkerId id = new MarkerId(clinic.getId());
      setState(() {
        markers[id] = newMarker;
        
      });
    }
    
    
  }

  void scrollToCard(String code){
    int index = -1;
    for(int i = 0; i < containerClinics.length; i++){
      if(containerClinics[i].HCI_CODE == code){
        index = i;
        break;
      }
    }
    if(index == -1)
      return;
    
    lvscrollController.animateTo(index * (300.0 + 10.0), duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchMinus, color: Color(0xff6200ee)),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus, color: Color(0xff6200ee)),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(1.3521, 103.8198), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(1.3521, 103.8198), zoom: zoomVal)));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView.builder(
          controller: lvscrollController,
          scrollDirection: Axis.horizontal,
          itemCount: containerClinics.length,
          itemBuilder: (context, position){

            return Card(
              child: Column(
                children: <Widget>[
                  SizedBox(width: 10.0, height: 20.0, ),
                  SizedBox(
                        width: 300.0, 
                        // height: 20.0,
                        child: _boxes(containerClinics[position]),
                        ),
                  
                    
                  
                ],
              ),
            );
            
          },
        ),
      ),
    );
  }

  Widget _boxes(Clinic clinic) {

    double lat = clinic.LATITUDE;
    double long  = clinic.LONGITUDE;
    Map<String,String> clinicDetails = clinic.getDetails();
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: createCardsInfo(clinicDetails),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget createCardsInfo(Map<String,String> clinicDetails) {

    // Map<String,dynamic> clinicDetails
    // 'name': HCI_NAME,
    // 'program': CLINIC_PROGRAMME_CODE.split(','),
    // 'buildingName': BUILDING_NAME,
    // 'street': BLK_HSE_NO + " " + STREET_NAME,
    // 'unit': "#" + FLOOR_NO + "-" + UNIT_NO,
    // 'phoneNo': HCI_TEL,

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            clinicDetails['name'].toString(),
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              clinicDetails['program'].toString(),
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
          ],
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          clinicDetails['buildingName'],
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
        Container(
            child: Text(
          clinicDetails['street'],
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
        Container(
            child: Text(
          clinicDetails['unit'],
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          clinicDetails['phoneNo'],
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        minMaxZoomPreference: MinMaxZoomPreference(15, 20),
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(1.346249, 103.681539), zoom: 15),
        onCameraIdle: () => mapScroll(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

Marker sghMarker = Marker(
  markerId: MarkerId('sgh'),
  position: LatLng(1.279525, 103.835915),
  infoWindow: InfoWindow(title: 'Singapore General Hospital'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker nuhMarker = Marker(
  markerId: MarkerId('National University Hospital'),
  position: LatLng(1.293971, 103.783207),
  infoWindow: InfoWindow(title: 'National University Hospital'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker tmcMarker = Marker(
  markerId: MarkerId('Thomson Medical Centre'),
  position: LatLng(1.325077, 103.841956),
  infoWindow: InfoWindow(title: 'Thomson Medical Centre'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
