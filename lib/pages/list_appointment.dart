import 'package:flutter/material.dart';
import 'package:my_medical_journal/controller/appointment_controller.dart';
import 'package:my_medical_journal/entities/appointment.dart';
import 'package:my_medical_journal/pages/view_appointment.dart';
import 'add_appointment.dart';
import '../menu.dart';
class appointmentPage extends StatefulWidget {
  @override
  State createState() => new AppointmentPageState();
}

class AppointmentPageState extends State<appointmentPage> {


  static List<String> items = [];
  static List<Widget> listItems = [];
  final TextEditingController eCtrl = new TextEditingController();
  AppointmentController appointmentController = new AppointmentController();

  void addToObserver() async{
    appointmentController.addAppointmentObserver((List<Appointment> appointmentList){
      updateAppointmentItems(appointmentList);
    });
  }

  void updateAppointmentItems(List<Appointment> appointmentList){
    setState(() {
      listItems = [];
    });
    for(var appointment in appointmentList){
      setState(() {
        listItems.add(createappointmentCard(appointment,context));
      });
    }
  }

  void retrieveAppointmentUpdate() async{
    List<Appointment> appointmentList = await appointmentController.listAppointment();
    updateAppointmentItems(appointmentList);
  }



  Widget createappointmentCard(Appointment appointment,dynamic context){

    return new Center(
      child: new Container(
        width: 400,
        height: 150,
        child: new Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              print('Card tapped.' + appointment.getId());


              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new ViewAppointment(generatedId: appointment.getId())
              )
              );

            },
            child: Column(
              children:<Widget>[
                Text(appointment.date,style: TextStyle(color:Colors.black54,fontSize:20,fontWeight: FontWeight.bold,fontFamily: "OpenSans"),
                ),
                Text(appointment.time,style: TextStyle(color:Colors.black54,fontSize:15,fontFamily: "OpenSans"),
                ),
                Text(appointment.clinicName,style: TextStyle(color:Colors.black54,fontSize:15,fontFamily: "OpenSans"),
                ),
                Text(appointment.appointName,style: TextStyle(color:Colors.black54,fontSize:15,fontFamily: "OpenSans"),
                ),

              ],
            ),
          ),
        ),
      ),
    );

  }

  @override
  void initState(){
    super.initState();
    retrieveAppointmentUpdate();
    addToObserver();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      //body: SingleChildScrollView(child: YourBody()),
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        flexibleSpace: new Container(
          alignment: Alignment.center,
          child: new Divider(
            color: Colors.white,
            thickness: 2,
          ),
        ),
        bottom: PreferredSize(
            child: new Container(), preferredSize: Size(100, 100)),
        title: new Row(
          children: <Widget>[
            new IconButton(
              icon: Icon(Icons.home),
              onPressed:
                  () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new MenuPage())),

            ),
            new Text(
              "Appointment Tracker",
              style: new TextStyle(
                  color: Colors.white, fontSize: 30, fontFamily: 'OpenSans'),
            ),
          ],
        ),
      ),
      body: new Material(
        color: Colors.white70,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new GridView.builder(
                  itemCount: listItems.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return listItems[index];
                  }),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new AddAppointment())),
        tooltip: 'Increment Counter',
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       resizeToAvoidBottomInset: false, // set it to false
//       //body: SingleChildScrollView(child: YourBody()),
//       appBar: new AppBar(
//         backgroundColor: Colors.green,
//         flexibleSpace: new Container(
//           alignment: Alignment.center,
//           child: new Divider(
//             color: Colors.white,
//             thickness: 2,
//           ),
//         ),
//         bottom: PreferredSize(
//             child: new Container(), preferredSize: Size(100, 100)),
//         title: new Row(
//           children: <Widget>[
//             new Text(
//               "appointment Tracker",
//               style: new TextStyle(
//                   color: Colors.white, fontSize: 30, fontFamily: 'OpenSans'),
//             ),
//           ],
//         ),
//       ),
//       body: new Material(
//         color: Colors.white70,
//         child: new Column(
//           children: <Widget>[
//             new TextField(
//               controller: eCtrl,
//               onSubmitted: (text) {
//                 litems.add(text);
//                 eCtrl.clear();
//                 setState(() {});
//               },
//             ),
//             new Expanded(
//               child: new GridView.builder(
//                   itemCount: litems.length,
//                   gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2),
//                   itemBuilder: (BuildContext context, int index) {
//                     return new Center(
//                       child: new Container(
//                         width: 400,
//                         height: 150,
//                         child: new Card(
//                           elevation: 10,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           color: Colors.white,
//                           child: InkWell(
//                             splashColor: Colors.blue.withAlpha(30),
//                             onTap: () {
//                               print('Card tapped.');
//                             },
//                             child: Column(
//                               children:<Widget>[
//                                 Text("appointment Name",style: TextStyle(color:Colors.black54,fontSize:20,fontWeight: FontWeight.bold,fontFamily: "OpenSans"),
//                                 ),
//                             Text("appointment Nickname",style: TextStyle(color:Colors.black54,fontSize:15,fontFamily: "OpenSans"),
//                             ),

//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//             ),
//           ],
//         ),
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
//             builder: (BuildContext context) => new Addappointment())),
//         tooltip: 'Increment Counter',
//         backgroundColor: Colors.green,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
