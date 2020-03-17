import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'add_blood_pressure.dart';

class ViewBloodPressure extends StatefulWidget{
  @override
  State createState() => new ViewBloodPressureState();
}


class ViewBloodPressureState extends State<ViewBloodPressure>{
  @override
  Widget build(BuildContext context) {
    Widget diastolics = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
          Text("111", style:TextStyle(fontSize:30, fontWeight: FontWeight.bold,),),
        ],
      ),
    );
    Widget systolic = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("88", style:TextStyle(fontSize:30, fontWeight: FontWeight.bold,),),
        ],
      ),
    );
    Widget heartrate = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("88", style:TextStyle(fontSize:30, fontWeight: FontWeight.bold,),),
        ],
      ),
      );
    Widget date = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("10/3/20", style:TextStyle(fontSize:25, fontWeight: FontWeight.bold,),),
          Text("2.00pm", style:TextStyle(fontSize:25, fontWeight: FontWeight.bold,),),
        ],
      ),
      );
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Blood Pressure'),
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
              child: new ListView.builder(itemBuilder: (context,index){
                return Card(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children:<Widget>[
                        date,
                        diastolics,
                        systolic,
                        heartrate,
                      ]
                    ),
                    ),
                    );
              }), 
              ),
          ],
        ),
      


      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new AddBloodPressure())),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}