import 'package:flutter/material.dart';
import 'package:my_medical_journal/controller/medication_controller.dart';
import 'package:my_medical_journal/entities/medication.dart';
import 'package:my_medical_journal/pages/view_medication.dart';
import 'add_medication.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../menu.dart';

class MedicationPage extends StatefulWidget {
  @override
  State createState() => new MedicationPageState();
}

class MedicationPageState extends State<MedicationPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int hour_morn = 10;
  int minute_morn= 6;
  int hour_afternoon = 14;
  int minute_afternoon= 10;
  int hour_night= 9;
  int minute_night= 0;

  Future onSelectNotification(String payload) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("ALERT"),
          content: Text("CONTENT: $payload"),
        ));
  }

  showNotification(int hour,int minute,String name,int dosage,int index) async{
    var time = Time(hour,minute , 0);
    var androidPlatformChannelSpecifics =
    AndroidNotificationDetails('repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name', 'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        index,
        "Take Medication: "+name,
        "Take Amount: "+dosage.toString(),
        time,
        platformChannelSpecifics);
    print("DONE");


  }

  @override
  void initState() {
    super.initState();
    retrieveMedicationUpdate();
    addToObserver();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  static List<Widget> listItems = [];
  static List<Medication> listmeds = [];

  MedicationController medicationController = new MedicationController();

  void addToObserver() async {
    medicationController
        .addMedicationObserver((List<Medication> medicationList) {
      updateMedicationItems(medicationList);
    });
  }

  void updateMedicationItems(List<Medication> medicationList) {
    int count=0;
    setState(() {
      listItems = [];
    });
    for (var medication in medicationList) {
      //print(medication);
      setState(() {

        if(medication.reminders[0] == true) {showNotification(hour_morn,minute_morn,medication.medication,medication.dosage,count);count++;reduceQuantity(hour_morn,minute_morn, medication);}
        if(medication.reminders[1] == true) {showNotification(hour_afternoon,minute_afternoon,medication.medication,medication.dosage,count);count++;reduceQuantity(hour_afternoon,minute_afternoon, medication);}
        if(medication.reminders[2] == true) {showNotification(hour_night,minute_night,medication.medication,medication.dosage,count);count++;reduceQuantity(hour_night,minute_night, medication);}
        listItems.add(createMedicationCard(medication, context));
      });
    }
  }

  void retrieveMedicationUpdate() async {
    List<Medication> medicationList =
        await medicationController.listMedication();
    updateMedicationItems(medicationList);
  }

  void reduceQuantity(int hour,int minute,Medication medication) async{
    var now = new DateTime.now();
    if(now.hour == hour && now.minute==minute){
      MedicationController medicationControllertemp = MedicationController();
      var old = medication.quantity;
      if(old<=0){
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
            0, 'Medication Low, Replenish!', medication.medication, platformChannelSpecifics,
            payload: "item");
      }
      print("REDUCING: "+medication.medication);
      medication.setQuantity(old-1);
      medicationControllertemp.editMedication(medication);

    }
  }
  Widget createMedicationCard(Medication medication, dynamic context) {
    return new Center(
      child: new Container(
        width: 400,
        height: 150,
        child: new Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              print('Card tapped.' + medication.getId());

              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new ViewMedication(generatedId: medication.getId())));
            },
            child: Column(
              children: <Widget>[
                Text(
                  medication.medication,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: "OpenSans"),
                ),
                Text(
                  medication.nickname,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontFamily: "OpenSans",
                    fontStyle: FontStyle.italic,
                  ),
                ),

                medication.specialInfo == null
                    ? Text(
                        "",
                      )
                    : Center(
                  heightFactor: 2,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Instructions:",style:TextStyle(
                      color: Colors.black54,)),
                    Text(medication.specialInfo,
                        style: TextStyle(
                          color: Colors.black54,
                        )),
                  ],
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new MenuPage())),
            ),
            new Text(
              "Medication Tracker",
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
            builder: (BuildContext context) => new AddMedication())),
        tooltip: 'Increment Counter',
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
