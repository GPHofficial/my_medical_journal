import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_medical_journal/controller/bp_controller.dart';
import '../entities/bloodPressure.dart';
import 'add_blood_pressure.dart';
import '../pages/list_health_vitals.dart';

class ViewBloodPressure extends StatefulWidget{
  ViewBloodPressure({Key key, this.generatedId}) : super(key: key);
  final String generatedId;
  @override
  State createState() => new ViewBloodPressureState(generatedId);
}


class ViewBloodPressureState extends State<ViewBloodPressure>{
  String generatedId;
  static List<Widget> listItems = [];
  ViewBloodPressureState(this.generatedId);
  BloodPressure bp = new BloodPressure.defaults();
  BpController bpController = new BpController();

  void addToBpObserver() async{
   bpController.addBpObserver((List<BloodPressure> bpList){
     updateBpItems(bpList);
   });
 } 

  void updateBpItems(List<BloodPressure> bpList){
    setState(() {
        listItems = [];
      });
    for(var bp in bpList){
      setState(() {
        listItems.add(createBpCard(bp,context));
      });
    }
  }

  void retrieveBpUpdate() async{
    List<BloodPressure> bpList = await bpController.listBp();
    updateBpItems(bpList);
  }

  Widget createBpCard(BloodPressure bp, dynamic context){
        Widget diastolics = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
          Text(bp.diastolic, style:TextStyle(fontSize:30, fontWeight: FontWeight.bold,),),
        ],
      ),
    );
    Widget systolic = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(bp.systolic, style:TextStyle(fontSize:30, fontWeight: FontWeight.bold,),),
        ],
      ),
    );
    Widget heartrate = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(bp.heartRate, style:TextStyle(fontSize:30, fontWeight: FontWeight.bold,),),
        ],
      ),
      );
    Widget date = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(bp.date, style:TextStyle(fontSize:25, fontWeight: FontWeight.bold,),),
          Text(bp.time, style:TextStyle(fontSize:25, fontWeight: FontWeight.bold,),),
        ],
      ),
      );
    return new Center(
      child: new Container(
        color: Colors.green,
        height: 85.0,
        child: new Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
          splashColor: Colors.green.withAlpha(100),
          onTap:(){
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new ViewBloodPressure(generatedId: bp.getId())
              )
            );  
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              date,
              diastolics,
              systolic,
              heartrate,
            ],)
        ),
        ),
        ),
      ),
    );
  }
  @override
  void initState(){
    super.initState();
    retrieveBpUpdate();
    addToBpObserver();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        //title: Text('Blood Pressure'),
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
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new HealthVitalsPage())),
            ),
            new Text(
              "Blood Pressure",
              style: new TextStyle(
                  color: Colors.white, fontSize: 30, fontFamily: 'OpenSans'),
            ),
          ],
        ),
      ),
      body: new Column(
          children:<Widget>[
            Container(
              height: 45.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:<Widget>[
                  Container(
                    padding: EdgeInsets.all(2.0),
                    width: 110.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Date", style:TextStyle(fontSize:20, fontWeight: FontWeight.bold,),),
                        Text("Time", style:TextStyle(fontSize:15, fontWeight: FontWeight.bold,),),
                      ],
                    ),
                    ),
                    Container(

                      padding: EdgeInsets.all(4.0),
                      width: 110.0,
                      child: Text("Diastolics",style:TextStyle(fontSize:18, fontWeight: FontWeight.bold,),),
                    ),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      width: 90.0,
                      child: Text("Systolic",style:TextStyle(fontSize:18, fontWeight: FontWeight.bold,),),
                    ),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      width: 90.0,
                      child: Text("Heart rate",style:TextStyle(fontSize:18, fontWeight: FontWeight.bold,),),
                    ),
                ]
              ),
            ),
            new Expanded(
              child: new ListView.builder(
                itemCount: listItems.length, // list.length to display all data
                itemBuilder: (context,index){
                  return listItems[index];
              }), 
              ),
          ],
        ),
      


      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new AddBloodPressure())),
        tooltip: 'Increment Counter',
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}